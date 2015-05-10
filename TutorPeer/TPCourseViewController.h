//
//  TPCourseViewController.h
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPCourse;
@class PFObject;

@interface TPCourseViewController : UIViewController

- (instancetype)initWithCourse:(TPCourse *)course;
- (instancetype)initWithPFObject:(PFObject *)courseObject;

@end
