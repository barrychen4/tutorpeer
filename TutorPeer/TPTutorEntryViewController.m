//
//  TPTutorEntryViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 6/4/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPTutorEntryViewController.h"
#import "TPTutorEntry.h"
#import "TPCourse.h"
#import "TPUser.h"
#import "TPContract.h"
#import "TPDBManager.h"
#import "TPNetworkManager.h"
#import <Parse/Parse.h>

@interface TPTutorEntryViewController ()

@property (strong, nonatomic) TPTutorEntry *tutorEntry;
@property (strong, nonatomic) TPContract *contract;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *courseLabel;
@property (strong, nonatomic) UILabel *blurbLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *registerTuteeButton;

@end

@implementation TPTutorEntryViewController

- (instancetype)initWithTutorEntry:(TPTutorEntry *)tutorEntry contract:(TPContract *)contract {
    self = [super init];
    if (self) {
        self.tutorEntry = tutorEntry;
        self.contract = contract;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.title = self.tutorEntry.course.courseName;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.courseLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 300, 50)];
    self.courseLabel.text = [NSString stringWithFormat:@"Course name: %@", self.tutorEntry.course.courseName];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 300, 50)];
    self.nameLabel.text = [NSString stringWithFormat:@"Tutor: %@", self.tutorEntry.tutorName];
    
    self.blurbLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 300, 100)];
    self.blurbLabel.text = [NSString stringWithFormat:@"Description: %@", self.tutorEntry.blurb];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 450, 300, 50)];
    self.priceLabel.text = [NSString stringWithFormat:@"Price: %@", [self.tutorEntry.price stringValue]];
    
    self.registerTuteeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    self.registerTuteeButton.center = CGPointMake(self.view.center.x, 550);
    [self.registerTuteeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.registerTuteeButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.registerTuteeButton addTarget:self action:@selector(toggleRegistration) forControlEvents:UIControlEventTouchUpInside];
    if (self.contract) {
        [self.registerTuteeButton setTitle:@"Unregister" forState:UIControlStateNormal];
    } else {
        [self.registerTuteeButton setTitle:@"Register" forState:UIControlStateNormal];
    }
    
    [self.view addSubview:self.courseLabel];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.blurbLabel];
    [self.view addSubview:self.priceLabel];
    [self.view addSubview:self.registerTuteeButton];
}

- (void)toggleRegistration {
    PFObject *courseObject = [PFQuery getObjectOfClass:@"Course" objectId:self.tutorEntry.course.objectId];
    if (!courseObject) {
        [self showRegisterErrorAlert];
    }
    else {
        if (!self.contract) {
            PFObject *contractPFObject = [PFObject objectWithClassName:@"Contract"];
            contractPFObject[@"price"] = self.tutorEntry.price;
            contractPFObject[@"course"] = self.tutorEntry.course.objectID;
            contractPFObject[@"tutor"] = self.tutorEntry.tutor.objectId;
            contractPFObject[@"tutee"] = [PFUser currentUser].objectId;
            contractPFObject[@"status"] = @(kTPContractStatusInitiated);
            NSError *error;
            [contractPFObject save:&error];
            if (error) {
                [self showRegisterErrorAlert];
            } else {
                NSMutableArray *userContracts = [NSMutableArray arrayWithArray:[PFUser currentUser][@"contracts"]];
                NSMutableArray *courseContracts = [NSMutableArray arrayWithArray:courseObject[@"contracts"]];
                [userContracts addObject:contractPFObject.objectId];
                [courseContracts addObject:contractPFObject.objectId];
                [PFUser currentUser][@"contracts"] = userContracts;
                courseObject[@"contracts"] = courseContracts;
                NSError *error;
                [PFObject saveAll:@[[PFUser currentUser], courseObject] error:&error];
                if (error) {
                    [self showRegisterErrorAlert];
                    return;
                }
                [[TPDBManager sharedInstance] updateLocalUser];
                [[TPNetworkManager sharedInstance] refreshContractsForUserId:[PFUser currentUser].objectId withCallback:^(NSError *error) {
                    TPUser *currentUser = [[TPDBManager sharedInstance] currentUser];
                    for (TPContract *contract in currentUser.contracts) {
                        if ([contract.tutor.objectId isEqual:self.tutorEntry.tutor.objectId]) {
                            self.contract = contract;
                            break;
                        }
                    }
                } async:NO];
                [self showRegisterSuccessAlert];
            }
        } else {
            PFObject *contractPFObject = [PFQuery getObjectOfClass:@"Contract" objectId:self.contract.objectId];
            if (!contractPFObject) {
                [self showUnregisterErrorAlert];
            } else {
                NSString *contractId = contractPFObject.objectId;
                NSError *error;
                [contractPFObject delete:&error];
                if (error) {
                    [self showUnregisterErrorAlert];
                } else {
                    NSMutableArray *userContracts = [NSMutableArray arrayWithArray:[PFUser currentUser][@"contracts"]];
                    NSMutableArray *courseContracts = [NSMutableArray arrayWithArray:courseObject[@"contracts"]];
                    [userContracts removeObject:contractId];
                    [courseContracts removeObject:contractId];
                    [PFUser currentUser][@"contracts"] = userContracts;
                    courseObject[@"contracts"] = courseContracts;
                    NSError *error;
                    [PFObject saveAll:@[[PFUser currentUser], courseObject] error:&error];
                    if (error) {
                        [self showRegisterErrorAlert];
                        return;
                    }
                    [[TPDBManager sharedInstance] updateLocalUser];
                    [[TPNetworkManager sharedInstance] refreshContractsForUserId:[PFUser currentUser].objectId withCallback:nil async:YES];
                    [[TPNetworkManager sharedInstance] refreshCoursesWithCallback:nil async:YES];
                    self.contract = nil;
                    [self showRegisterSuccessAlert];
                }
            }
        }
    }
}

- (void)showRegisterErrorAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not register" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)showRegisterSuccessAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully registered!" message:[NSString stringWithFormat:@"Registered as tutee for %@", self.tutorEntry.course.courseName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)showUnregisterErrorAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not unregister" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)showUnregisterSuccessAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully unregistered!" message:[NSString stringWithFormat:@"Unregistered as tutee for %@", self.tutorEntry.course.courseName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
