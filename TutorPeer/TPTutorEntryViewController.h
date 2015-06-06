//
//  TPTutorEntryViewController.h
//  TutorPeer
//
//  Created by Ethan Yu on 6/4/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPTutorEntry, TPContract;

@interface TPTutorEntryViewController : UIViewController

- (instancetype)initWithTutorEntry:(TPTutorEntry *)tutorEntry contract:(TPContract *)contract;

@end
