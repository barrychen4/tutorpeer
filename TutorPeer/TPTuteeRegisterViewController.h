//
//  TPTuteeRegisterViewController.h
//  TutorPeer
//
//  Created by Ethan Yu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPCourse;
@class PFObject;

@interface TPTuteeRegisterViewController : UIViewController <UITextFieldDelegate>

- (instancetype)initWithCourse:(TPCourse *)course;
- (instancetype)initWithPFObject:(PFObject *)courseObject;

@end
