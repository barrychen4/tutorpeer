//
//  TPTuteeRegisterViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPTuteeRegisterViewController.h"
#import <Parse/Parse.h>

@interface TPTuteeRegisterViewController()

@property (strong, nonatomic) PFObject *courseObject;
@property (strong, nonatomic) PFObject *tutorEntryObject;
@property (strong, nonatomic) PFObject *tuteeEntryObject;
@property (strong, nonatomic) UILabel *confirmLabel;
@property (strong, nonatomic) UIButton *registerButton;

@end

@implementation TPTuteeRegisterViewController

- (instancetype)initWithTutorEntryObject:(PFObject *)tutorEntryObject courseObject:(PFObject *)courseObject {
    self = [super init];
    if (self) {
        _tutorEntryObject = tutorEntryObject;
        _courseObject = courseObject;
    }
    return self;
}

- (void)viewDidLoad {
    self.title = @"Register as tutee";
    self.view.backgroundColor = [UIColor whiteColor];

    _confirmLabel = [[UILabel alloc] init];
    _confirmLabel.frame = CGRectMake(20, 200, 400, 200);
    if (![self registered]) {
        _confirmLabel.text = [NSString stringWithFormat:@"Request %@ as your tutor for $%@?\nDescription: %@", _tutorEntryObject[@"tutor"], _tutorEntryObject[@"price"], _tutorEntryObject[@"blurb"]];
        _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
        _registerButton.center = CGPointMake(self.view.center.x, 300);
        [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerTutee) forControlEvents:UIControlEventTouchUpInside];
    } else {
        PFQuery *query = [PFQuery queryWithClassName:@"TuteeEntry"];
        [query whereKey:@"tutee" equalTo:[PFUser currentUser].username];
        [query whereKey:@"course" equalTo:_courseObject[@"courseCode"]];
        [query whereKey:@"tutor" equalTo:_tutorEntryObject[@"tutor"]];
        _tuteeEntryObject = [query findObjects][0];
        _confirmLabel.text = [NSString stringWithFormat:@"You already have %@ as your tutor for $%@?\nDescription: %@", _tutorEntryObject[@"tutor"], _tutorEntryObject[@"price"], _tutorEntryObject[@"blurb"]];
        _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
        _registerButton.center = CGPointMake(self.view.center.x, 300);
        [_registerButton setTitle:@"Unregister" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(unregisterTutee) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (BOOL)registered {
    return [_courseObject[@"tutees"] containsObject:[PFUser currentUser].username];
}

- (void)registerTutee {
    PFObject *tuteeEntry = [PFObject objectWithClassName:@"TuteeEntry"];
    tuteeEntry[@"course"] = _tutorEntryObject[@"course"];
    tuteeEntry[@"tutor"] = _tutorEntryObject[@"tutor"];
    [_tutorEntryObject addUniqueObject:[PFUser currentUser].username forKey:@"tutees"];
    [_courseObject addUniqueObject:[PFUser currentUser].username forKey:@"tutees"];
    [PFObject saveAllInBackground:@[tuteeEntry, _tutorEntryObject, _courseObject] block:^(BOOL success, NSError *error) {
        if (success) {
            NSString *objectID = tuteeEntry.objectId;
            [_courseObject addUniqueObject:objectID forKey:@"tuteeEntries"];
            [[PFUser currentUser] addUniqueObject:objectID forKey:@"tuteeEntries"];
            [PFObject saveAllInBackground:@[_courseObject, [PFUser currentUser]] block:^(BOOL success, NSError *error) {
                if (success) {
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not register" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not save" message:@"Please check your internet connections" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];  
}

- (void)unregisterTutee {
    [_tutorEntryObject removeObject:[PFUser currentUser].username forKey:@"tutees"];
    [_courseObject removeObject:[PFUser currentUser].username forKey:@"tutees"];
    [_courseObject removeObject:_tuteeEntryObject.objectId forKey:@"tuteeEntries"];
    [[PFUser currentUser] removeObject:_tuteeEntryObject.objectId forKey:@"tuteeEntries"];
    [PFObject saveAllInBackground:@[_tutorEntryObject, _courseObject, [PFUser currentUser]] block:^(BOOL success, NSError *error) {
        if (success) {
            [_tuteeEntryObject deleteInBackgroundWithBlock:^(BOOL success, NSError *error) {
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
