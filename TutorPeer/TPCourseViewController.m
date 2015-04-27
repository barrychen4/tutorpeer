//
//  TPCourseViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPCourseViewController.h"
#import "TPCourseView.h"

@interface TPCourseViewController ()

@end

@implementation TPCourseViewController

- (instancetype)initWithCourse:(NSString *)course {
    self = [super init];
    if (self) {
        self.view = [[TPCourseView alloc] initWithCourse:course];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
