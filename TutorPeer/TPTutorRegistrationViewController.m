//
//  TPTutorRegistrationViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPTutorRegistrationViewController.h"
#import "TPDBManager.h"
#import "TPNetworkManager.h"
#import "TPCourse.h"
#import "TPTutorEntry.h"
#import "TPUser.h"

@interface TPTutorRegistrationViewController()

@property (strong, nonatomic) TPCourse *course;
@property (strong, nonatomic) TPTutorEntry *tutorEntry;
@property (strong, nonatomic) UITextField *priceTextField;
@property (strong, nonatomic) UITextField *blurbTextField;
@property (strong, nonatomic) UIButton *unRegisterButton;

@end

@implementation TPTutorRegistrationViewController

- (instancetype)initWithCourse:(TPCourse *)course tutorEntry:(TPTutorEntry *)tutorEntry {
    self = [super init];
    if (self) {
        self.course = course;
        self.tutorEntry = tutorEntry;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.title = @"Registration";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Register" style:UIBarButtonItemStylePlain target:self action:@selector(registerTutor)];
    [rightBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:16.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIView *pricePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    self.priceTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.priceTextField.layer.cornerRadius = 5;
    self.priceTextField.clipsToBounds = YES;
    self.priceTextField.backgroundColor = [UIColor whiteColor];
    self.priceTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.priceTextField.layer.borderWidth = 1.0f;
    self.priceTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.priceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.priceTextField.center = CGPointMake(self.view.center.x, 100);
    self.priceTextField.leftView = pricePaddingView;
    self.priceTextField.leftViewMode = UITextFieldViewModeAlways;
    self.priceTextField.delegate = self;
    if (self.tutorEntry) {
        self.priceTextField.text = [self.tutorEntry.price stringValue];
    } else {
        NSNumber *defaultPrice = [[TPDBManager sharedInstance] currentUser].defaultPrice;
        if (defaultPrice) {
            self.priceTextField.text = [defaultPrice stringValue];
        } else {
            self.priceTextField.text = @"15";
        }
    }
    
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
    if (self.tutorEntry) {
        self.blurbTextField.text = self.tutorEntry.blurb;
    } else {
        NSString *defaultBio = [[TPDBManager sharedInstance] currentUser].defaultBio;
        if (defaultBio) {
            self.priceTextField.text = defaultBio;
        } else {
            self.priceTextField.text = [NSString stringWithFormat:@"Hi, my name is %@! Please let me be your tutor.", [[TPDBManager sharedInstance] currentUser].firstName];
        }
    }
    
    [self.view addSubview:self.priceTextField];
    [self.view addSubview:self.blurbTextField];
    
    if (self.tutorEntry) {
        self.unRegisterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.unRegisterButton.center = self.view.center;
        [self.unRegisterButton setTitle:@"Unregister" forState:UIControlStateNormal];
        [self.unRegisterButton addTarget:self action:@selector(unregisterTutor) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.unRegisterButton];
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)hideKeyboard:(id)sender {
    [self.priceTextField resignFirstResponder];
}

- (void)registerTutor {
//    PFObject *tutorEntry = self.tutorEntryObject == nil ? [PFObject objectWithClassName:@"TutorEntry"] : self.tutorEntryObject;
//    tutorEntry[@"price"] = @([self.priceTextField.text integerValue]);
//    tutorEntry[@"tutor"] = [PFUser currentUser].username;
//    tutorEntry[@"blurb"] = self.blurbTextField.text;
//    tutorEntry[@"course"] = self.courseObject[@"courseCode"];
//    
//    [tutorEntry saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            NSString *objectID = tutorEntry.objectId;
//            [[PFUser currentUser] addUniqueObject:objectID forKey:@"tutorEntries"];
//            [self.courseObject addUniqueObject:objectID forKey:@"tutorEntries"];
//            [self.courseObject addUniqueObject:[PFUser currentUser].username forKey:@"tutors"];
//            [PFObject saveAllInBackground:@[[PFUser currentUser], self.courseObject] block:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//                    [self.navigationController popViewControllerAnimated:YES];
//                } else {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not register" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [alert show];
//                }
//            }];
//        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not save" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        }
//    }];
}

- (void)unregisterTutor {
//    [self.courseObject removeObject:[PFUser currentUser].username forKey:@"tutors"];
//    [self.courseObject removeObject:self.tutorEntryObject.objectId forKey:@"tutorEntries"];
//    [[PFUser currentUser] removeObject:self.tutorEntryObject.objectId forKey:@"tutorEntries"];
//    [PFObject saveAllInBackground:@[self.courseObject, [PFUser currentUser]] block:^(BOOL success, NSError *error) {
//        if (success) {
//            [self.tutorEntryObject deleteInBackgroundWithBlock:^(BOOL success, NSError *error) {
//                if (success) {
//                    [self.navigationController popViewControllerAnimated:YES];
//                } else {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not unregister" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [alert show];
//                }
//            }];
//        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not delete" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        }
//    }];
}

@end
