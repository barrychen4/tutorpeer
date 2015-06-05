//
//  TPCourseViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPCourseViewController.h"
#import "TPCourse.h"
#import "TPUser.h"
#import "TPTutorEntry.h"
#import "TPContract.h"
#import "TPDbManager.h"
#import "TPNetworkManager.h"
#import "TPTutorRegistrationViewController.h"
#import "TPTutorsListViewController.h"


@interface TPCourseViewController ()

@property (strong, nonatomic) TPCourse *course;
@property (strong, nonatomic) TPTutorEntry *currentUserTutorEntry;
@property (strong, nonatomic) UILabel *courseLabel;
@property (strong, nonatomic) UILabel *tutorsLabel;
@property (strong, nonatomic) UIButton *registerTutorButton;
@property (strong, nonatomic) UIButton *viewTutorsButton;

@end

@implementation TPCourseViewController

- (instancetype)initWithCourseObject:(TPCourse *)course {
    self = [super init];
    if (self) {
        self.course = course;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self isRegisteredAsTutor]) {
        [self.registerTutorButton setTitle:@"Edit tutor registration" forState:UIControlStateNormal];
    } else {
        [self.registerTutorButton setTitle:@"Register as tutor" forState:UIControlStateNormal];
    }
    [[TPNetworkManager sharedInstance] getTutorEntriesForCourseId:self.course.objectId withCallback:^(NSArray *tutorEntries) {
        for (TPTutorEntry *tutorEntry in tutorEntries) {
            if ([tutorEntry.tutor.objectId isEqualToString:[[TPDBManager sharedInstance] currentUser].objectId]) {
                self.currentUserTutorEntry = tutorEntry;
            }
        }
    } delta:YES];
}

- (void)setupView {
    self.title = self.course.courseName;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.courseLabel = [[UILabel alloc] init];
    self.courseLabel.frame = CGRectMake(20, 100, 300, 50);
    self.courseLabel.text = [NSString stringWithFormat:@"Course name: %@", self.course.courseName];
    
    self.tutorsLabel = [[UILabel alloc] init];
    self.tutorsLabel.frame = CGRectMake(20, 200, 400, 50);
    self.tutorsLabel.text = [NSString stringWithFormat:@"Tutors: %lu", (unsigned long)[self.course.tutorEntries count]];
    
    self.registerTutorButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    self.registerTutorButton.center = CGPointMake(self.view.center.x, 300);
    [self.registerTutorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.registerTutorButton addTarget:self action:@selector(registerTutor) forControlEvents:UIControlEventTouchUpInside];
    
    self.viewTutorsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    self.viewTutorsButton.center = CGPointMake(self.view.center.x, 400);
    [self.viewTutorsButton setTitle:@"Register As Tutee" forState:UIControlStateNormal];
    [self.viewTutorsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.viewTutorsButton addTarget:self action:@selector(viewTutors) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.courseLabel];
    [self.view addSubview:self.tutorsLabel];
    [self.view addSubview:self.registerTutorButton];
    [self.view addSubview:self.viewTutorsButton];
}

- (BOOL)isRegisteredAsTutor {
    BOOL registered = NO;
    TPUser *currentUser = [[TPDBManager sharedInstance] currentUser];
    for (TPTutorEntry *tutorEntry in currentUser.tutorEntries) {
        if ([tutorEntry.course.objectId isEqual:self.course.objectId]) {
            NSLog(@"Registered as tutor");
            registered = YES;
            break;
        }
    }
    return registered;
}

- (BOOL)isRegisteredAsTutee {
    BOOL registered = NO;
    TPUser *currentUser = [[TPDBManager sharedInstance] currentUser];
    for (TPContract *contract in currentUser.contracts) {
        if ([contract.course.objectId isEqual:self.course.objectId]) {
            NSLog(@"Registered as tutee");
            registered = YES;
            break;
        }
    }
    return registered;
}

- (void)registerTutor {
    TPTutorRegistrationViewController *tutorRegistrationViewController = [[TPTutorRegistrationViewController alloc] initWithCourse:self.course];
    [self.navigationController pushViewController:tutorRegistrationViewController animated:YES];
}

- (void)viewTutors {
    TPTutorsListViewController *tuteeRegisterViewController = [[TPTutorsListViewController alloc] initWithCourse:self.course];
    [self.navigationController pushViewController:tuteeRegisterViewController animated:YES];
}

@end
