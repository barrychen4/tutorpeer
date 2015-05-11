//
//  TPTutorsListViewController.h
//  TutorPeer
//
//  Created by Ethan Yu on 5/10/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFObject;

@interface TPTutorsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithCourseObject:(PFObject *)courseObject;

@end
