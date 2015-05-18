//
//  TPTutorRegisterViewController.h
//  TutorPeer
//
//  Created by Ethan Yu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFObject;

@interface TPTutorRegisterViewController : UIViewController <UITextFieldDelegate>

- (instancetype)initWithCourseObject:(PFObject *)courseObject;

@end