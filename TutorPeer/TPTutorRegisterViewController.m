//
//  TPTutorRegisterViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPTutorRegisterViewController.h"
#import <Parse/Parse.h>

@interface TPTutorRegisterViewController()

@property (strong, nonatomic) PFObject *courseObject;
@property (strong, nonatomic) PFObject *tutorEntryObject;
@property (strong, nonatomic) UITextField *priceTextField;
@property (strong, nonatomic) UITextField *blurbTextField;
@property (strong, nonatomic) UIButton *registerButton;

@end

@implementation TPTutorRegisterViewController

- (instancetype)initWithCourseObject:(PFObject *)courseObject {
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
    self.priceTextField.backgroundColor = [UIColor whiteColor];
    self.priceTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.priceTextField.layer.borderWidth = 1.0f;
    self.priceTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.priceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.priceTextField.center = CGPointMake(self.view.center.x, 100);
    self.priceTextField.leftView = pricePaddingView;
    self.priceTextField.leftViewMode = UITextFieldViewModeAlways;
    self.priceTextField.delegate = self;
    [self.view addSubview:self.priceTextField];
    
    UIView *blurbPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.blurbTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 100)];
    self.blurbTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.blurbTextField.layer.cornerRadius = 5;
    self.blurbTextField.clipsToBounds = YES;
    self.blurbTextField.placeholder = @"Blurb";
    self.blurbTextField.backgroundColor = [UIColor whiteColor];
    self.blurbTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.blurbTextField.layer.borderWidth = 1.0f;
    self.blurbTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.blurbTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.blurbTextField.center = CGPointMake(self.view.center.x, 200);
    self.blurbTextField.leftView = blurbPaddingView;
    self.blurbTextField.leftViewMode = UITextFieldViewModeAlways;
    self.blurbTextField.delegate = self;
    [self.view addSubview:self.blurbTextField];
    
    _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    _registerButton.center = CGPointMake(self.view.center.x, 350);
    [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if ([self registeredAsTutor]) {
        // Get tutor entry information
        PFQuery *query = [PFQuery queryWithClassName:@"TutorEntry"];
        [query whereKey:@"tutor" equalTo:[PFUser currentUser].username];
        [query whereKey:@"course" equalTo:_courseObject[@"courseCode"]];
        _tutorEntryObject = [query findObjects][0];
        self.priceTextField.text = [_tutorEntryObject[@"price"] stringValue];
        self.blurbTextField.text = _tutorEntryObject[@"blurb"];
        [_registerButton setTitle:@"Unregister" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(unregisterTutor) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerTutor) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)hideKeyboard:(id)sender {
    [self.priceTextField resignFirstResponder];
}

- (BOOL)registeredAsTutor {
    return [_courseObject[@"tutors"] containsObject:[PFUser currentUser].username];
}

- (void)registerTutor {
    PFObject *tutorEntry = _tutorEntryObject == nil ? [PFObject objectWithClassName:@"TutorEntry"] : _tutorEntryObject;
    tutorEntry[@"price"] = @([self.priceTextField.text integerValue]);
    tutorEntry[@"tutor"] = [PFUser currentUser].username;
    tutorEntry[@"blurb"] = self.blurbTextField.text;
    tutorEntry[@"course"] = _courseObject[@"courseCode"];
    
    [tutorEntry saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSString *objectID = tutorEntry.objectId;
            [[PFUser currentUser] addUniqueObject:objectID forKey:@"tutorEntries"];
            [_courseObject addUniqueObject:objectID forKey:@"tutorEntries"];
            [_courseObject addUniqueObject:[PFUser currentUser].username forKey:@"tutors"];
            [PFObject saveAllInBackground:@[[PFUser currentUser], _courseObject] block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not register" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not save" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (void)unregisterTutor {
    [_courseObject removeObject:[PFUser currentUser].username forKey:@"tutors"];
    [_courseObject removeObject:_tutorEntryObject.objectId forKey:@"tutorEntries"];
    [[PFUser currentUser] removeObject:_tutorEntryObject.objectId forKey:@"tutorEntries"];
    [PFObject saveAllInBackground:@[_courseObject, [PFUser currentUser]] block:^(BOOL success, NSError *error) {
        if (success) {
            [_tutorEntryObject deleteInBackgroundWithBlock:^(BOOL success, NSError *error) {
                if (success) {
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not unregister" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not delete" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

@end
