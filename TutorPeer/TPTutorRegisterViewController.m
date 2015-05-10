//
//  TPTutorRegisterViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPTutorRegisterViewController.h"
#import "TPCourse.h"
#import <Parse/Parse.h>

@interface TPTutorRegisterViewController()

@property (strong, nonatomic) TPCourse *course;
@property (strong, nonatomic) PFObject *courseObject;
@property (strong, nonatomic) UITextField *priceTextField;
@property (strong, nonatomic) PFObject *tutorEntry;

@end

@implementation TPTutorRegisterViewController

- (instancetype)initWithCourse:(TPCourse *)course {
    self = [super init];
    if (self) {
        _course = course;
    }
    return self;
}

- (instancetype)initWithPFObject:(PFObject *)courseObject {
    self = [super init];
    if (self) {
        _courseObject = courseObject;
    }
    return self;
}

- (void)viewDidLoad {
    self.title = @"Register as tutor";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(registerTutor)];
    [rightBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:16.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIView *pricePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    self.priceTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.priceTextField.layer.cornerRadius = 5;
    self.priceTextField.clipsToBounds = YES;
    self.priceTextField.placeholder = @"Price";
    if ([self registeredAsTutor]) {
        PFQuery *query = [PFQuery queryWithClassName:@"TutorEntry"];
        [query whereKey:@"tutor" equalTo:[PFUser currentUser].username];
        [query whereKey:@"course" equalTo:_courseObject[@"courseCode"]];
        _tutorEntry = [query findObjects][0];
        self.priceTextField.placeholder = _tutorEntry[@"price"];
    }
    self.priceTextField.backgroundColor = [UIColor whiteColor];
    self.priceTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.priceTextField.layer.borderWidth = 1.0f;
    self.priceTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.priceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.priceTextField.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
    self.priceTextField.leftView = pricePaddingView;
    self.priceTextField.leftViewMode = UITextFieldViewModeAlways;
    self.priceTextField.delegate = self;
    [self.view addSubview:self.priceTextField];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)hideKeyboard:(id)sender {
    [self.priceTextField resignFirstResponder];
}

- (BOOL)registeredAsTutor {
    return [_courseObject[@"tutors"] containsString:[PFUser currentUser].username];
}

- (void)registerTutor {
    PFObject *entry = [PFObject objectWithClassName:@"TutorEntry"];
    entry[@"price"] = @([self.priceTextField.text integerValue]);
    entry[@"tutor"] = [PFUser currentUser].username;
    entry[@"course"] = _courseObject[@"courseCode"];
    
    [entry saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSString *objectID = entry.objectId;
            NSLog(@"Succeeded 1 %@", objectID);
            [[PFUser currentUser] addUniqueObject:objectID forKey:@"tutorEntries"];
            [_courseObject addUniqueObject:objectID forKey:@"tutorEntries"];
            [PFObject saveAllInBackground:@[[PFUser currentUser], _courseObject] block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"Succeeded 2");
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    NSLog(@"Failed 1");
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not register" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        } else {
            NSLog(@"Failed 2");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not save" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
    
}

@end
