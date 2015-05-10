//
//  TPTuteeRegisterViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPTuteeRegisterViewController.h"
#import "TPCourse.h"
#import <Parse/Parse.h>

@interface TPTuteeRegisterViewController()

@property (strong, nonatomic) TPCourse *course;
@property (strong, nonatomic) PFObject *tutorEntryObject;
@property (strong, nonatomic) UILabel *confirmLabel;
@property (strong, nonatomic) UIButton *registerButton;

@end

@implementation TPTuteeRegisterViewController

- (instancetype)initWithCourse:(TPCourse *)course {
    self = [super init];
    if (self) {
        _course = course;
    }
    return self;
}

- (instancetype)initWithPFObject:(PFObject *)tutorEntryObject {
    self = [super init];
    if (self) {
        _tutorEntryObject = tutorEntryObject;
    }
    return self;
}

- (void)viewDidLoad {
    self.title = @"Register as tutee";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Profile";
    _confirmLabel = [[UILabel alloc] init];
    _confirmLabel.frame = CGRectMake(20, 200, 200, 150);
    _confirmLabel.text = [NSString stringWithFormat:@"Request %@ as your tutor for %@?", _tutorEntryObject[@"tutor"], _tutorEntryObject[@"price"]];

    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)registerTutee {
    PFObject *tuteeEntry = [PFObject objectWithClassName:@"TuteeEntry"];
    tuteeEntry[@"course"] = _tutorEntryObject[@"course"];
    tuteeEntry[@"tutor"] = _tutorEntryObject[@"tutor"];
    [_tutorEntryObject addObject:[PFUser currentUser].username forKey:@"tutees"];
    // Add to course //
    // Add tuteeEntry objectID to user //
    [self.navigationController popViewControllerAnimated:YES];
}

@end
