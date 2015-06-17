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
#import "TPNetworkManager+CourseRequests.h"
#import "TPNetworkManager+ContractRequests.h"
#import "TPNetworkManager+TutorEntryRequests.h"
#import "TPCourse.h"
#import "TPTutorEntry.h"
#import "TPUser.h"
#import <Parse/Parse.h>

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
    
    UIBarButtonItem *rightBarButton;
    if (self.tutorEntry) {
        rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(registerTutor)];
    } else {
        rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Register" style:UIBarButtonItemStylePlain target:self action:@selector(registerTutor)];
    }
    [rightBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:16.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIView *pricePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    self.priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
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
            self.blurbTextField.text = defaultBio;
        } else {
            self.blurbTextField.text = [NSString stringWithFormat:@"Hi, my name is %@! Please let me be your tutor.", [TPUser currentUser].firstName];
        }
    }
    
    [self.view addSubview:self.priceTextField];
    [self.view addSubview:self.blurbTextField];
    
    if (self.tutorEntry) {
        self.unRegisterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        self.unRegisterButton.center = self.view.center;
        [self.unRegisterButton setTitle:@"Unregister" forState:UIControlStateNormal];
        [self.unRegisterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.unRegisterButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.unRegisterButton addTarget:self action:@selector(unregisterTutor) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.unRegisterButton];
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)hideKeyboard:(id)sender {
    [self.priceTextField resignFirstResponder];
}

//- (void)registerTutor {
//    PFObject *tutorEntryPFObject;
//    if (self.tutorEntry) {
//        tutorEntryPFObject = [PFQuery getObjectOfClass:@"TutorEntry" objectId:self.tutorEntry.objectId];
//        if (!tutorEntryPFObject) {
//            [self showRegisterErrorAlert];
//        } else {
//            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
//            f.numberStyle = NSNumberFormatterDecimalStyle;
//            tutorEntryPFObject[@"price"] = [f numberFromString:self.priceTextField.text];
//            tutorEntryPFObject[@"blurb"] = self.blurbTextField.text;
//            
//            [tutorEntryPFObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (!error) {
//                    if (succeeded) {
//                        [[TPNetworkManager sharedInstance] refreshTutorEntriesForCourseId:self.course.objectId withCallback:nil];
//                    } else {
//                        NSLog(@"Save in background failed");
//                    }
//                } else {
//                    NSLog(@"%@", [error localizedDescription]);
//                    [self showRegisterErrorAlert];
//                }
//            }];
//            
//        }
//    } else {
//        PFObject *courseObject = [PFQuery getObjectOfClass:@"Course" objectId:self.course.objectId];
//        if (!courseObject) {
//            [self showRegisterErrorAlert];
//        } else {
//            tutorEntryPFObject = [PFObject objectWithClassName:@"TutorEntry"];
//            tutorEntryPFObject[@"course"] = self.course.objectId;
//            tutorEntryPFObject[@"tutor"] = [TPUser currentUser].objectId;
//            tutorEntryPFObject[@"tutorName"] = [NSString stringWithFormat:@"%@ %@", [TPUser currentUser].firstName, [TPUser currentUser].lastName];
//            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
//            f.numberStyle = NSNumberFormatterDecimalStyle;
//            tutorEntryPFObject[@"price"] = [f numberFromString:self.priceTextField.text];
//            tutorEntryPFObject[@"blurb"] = self.blurbTextField.text;
//            
//            [tutorEntryPFObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (!error) {
//                    if (succeeded) {
//                        NSMutableArray *userTutorEntries = [NSMutableArray arrayWithArray:[PFUser currentUser][@"tutorEntries"]];
//                        NSMutableArray *courseTutorEntries = [NSMutableArray arrayWithArray:courseObject[@"tutorEntries"]];
//                        [userTutorEntries addObject:tutorEntryPFObject.objectId];
//                        [courseTutorEntries addObject:tutorEntryPFObject.objectId];
//                        [PFUser currentUser][@"tutorEntries"] = userTutorEntries;
//                        courseObject[@"tutorEntries"] = courseTutorEntries;
//                        NSError *error;
//                        [PFObject saveAll:@[[PFUser currentUser], courseObject] error:&error];
//                        if (error) {
//                            [self showRegisterErrorAlert];
//                            return;
//                        }
//                        [[TPDBManager sharedInstance] updateLocalUser];
//                        [[TPNetworkManager sharedInstance] refreshCoursesWithCallback:nil];
//                        [[TPNetworkManager sharedInstance] refreshTutorEntriesForCourseId:self.course.objectId withCallback:^(NSError *error) {
//                            if (!error) {
//                                TPUser *currentUser = [[TPDBManager sharedInstance] currentUser];
//                                for (TPTutorEntry *tutorEntry in currentUser.tutorEntries) {
//                                    if ([tutorEntry.course.objectId isEqual:self.course.objectId]) {
//                                        self.tutorEntry = tutorEntry;
//                                        break;
//                                    }
//                                }
//                            }
//                        }];
//                        [self showRegisterSuccessAlert];
//                    } else {
//                        NSLog(@"Save in background failed");
//                    }
//                } else {
//                    NSLog(@"%@", [error localizedDescription]);
//                    [self showRegisterErrorAlert];
//                }
//            }];
//            
//
//        }
//    }
//}

- (void)registerTutor {
    if (self.tutorEntry) {
        [[TPNetworkManager sharedInstance] updateTutorEntryWithId:self.tutorEntry.objectId withPrice:[self.priceTextField.text intValue] withBlurb:self.blurbTextField.text withCallback:^(NSError *error) {
            
            if (!error) {
                [[TPNetworkManager sharedInstance] refreshTutorEntriesForCourseId:self.course.objectId withCallback:nil];
                
                [self showRegisterSuccessAlert];
            } else {
                [self showRegisterErrorAlert];
            }
        }];
        
    } else {
        [[TPNetworkManager sharedInstance] registerAsTutorForCourseId:self.course.objectId withPrice:[self.priceTextField.text intValue] withBlurb:self.blurbTextField.text withCallback:^(NSError *error) {
            
            if (!error) {
                [[TPNetworkManager sharedInstance] refreshCoursesWithCallback:nil];
                [[TPNetworkManager sharedInstance] refreshTutorEntriesForCourseId:self.course.objectId withCallback:^(NSError *error) {
                    if (!error) {
                        TPUser *currentUser = [[TPDBManager sharedInstance] currentUser];
                        for (TPTutorEntry *tutorEntry in currentUser.tutorEntries) {
                            if ([tutorEntry.course.objectId isEqual:self.course.objectId]) {
                                self.tutorEntry = tutorEntry;
                                break;
                            }
                        }
                    }
                }];
                
                [self showRegisterSuccessAlert];
            } else {
                [self showRegisterErrorAlert];
            }
        }];
        
    }
}


//- (void)unregisterTutor {
//    PFObject *tutorEntryPFObject = [PFQuery getObjectOfClass:@"TutorEntry" objectId:self.tutorEntry.objectId];
//    if (!tutorEntryPFObject) {
//        [self showUnregisterErrorAlert];
//    } else {
//        PFObject *courseObject = [PFQuery getObjectOfClass:@"Course" objectId:self.course.objectId];
//        if (!courseObject) {
//            [self showUnregisterErrorAlert];
//        } else {
//            NSString *tutorEntryId = tutorEntryPFObject.objectId;
//            NSError *error;
//            [tutorEntryPFObject delete:&error];
//            if (error) {
//                [self showUnregisterErrorAlert];
//            } else {
//                NSMutableArray *userTutorEntries = [NSMutableArray arrayWithArray:[PFUser currentUser][@"tutorEntries"]];
//                NSMutableArray *courseTutorEntries = [NSMutableArray arrayWithArray:courseObject[@"tutorEntries"]];
//                [userTutorEntries removeObject:tutorEntryId];
//                [courseTutorEntries removeObject:tutorEntryId];
//                [PFUser currentUser][@"tutorEntries"] = userTutorEntries;
//                courseObject[@"tutorEntries"] = courseTutorEntries;
//                NSError *error;
//                [PFObject saveAll:@[[PFUser currentUser], courseObject] error:&error];
//                if (error) {
//                    [self showRegisterErrorAlert];
//                    return;
//                }
//                [[TPDBManager sharedInstance] updateLocalUser];
//                [[TPNetworkManager sharedInstance] refreshCoursesWithCallback:nil];
//                [[TPNetworkManager sharedInstance] refreshTutorEntriesForCourseId:self.course.objectId withCallback:nil];
//                self.tutorEntry = nil;
//                [self showRegisterSuccessAlert];
//            }
//        }
//    }
//}

- (void)unregisterTutor {
    [[TPNetworkManager sharedInstance] unregisterAsTutorWithId:self.tutorEntry.objectId forCourseId:self.course.objectId withCallback:^(NSError *error) {
        if (!error) {
            [[TPNetworkManager sharedInstance] refreshCoursesWithCallback:nil];
            [[TPNetworkManager sharedInstance] refreshTutorEntriesForCourseId:self.course.objectId withCallback:nil];
            self.tutorEntry = nil;
            [self showRegisterSuccessAlert];
        } else {
            [self showUnregisterErrorAlert];
        }
    }];
}

- (void)showRegisterErrorAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not register" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)showRegisterSuccessAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully registered!" message:[NSString stringWithFormat:@"Registered as tutor for %@", self.course.courseName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)showUnregisterErrorAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not unregister" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)showUnregisterSuccessAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully unregistered!" message:[NSString stringWithFormat:@"Unregistered as tutor for %@", self.course.courseName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
