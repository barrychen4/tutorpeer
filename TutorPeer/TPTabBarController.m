//
//  TPTabBarController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/27/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPTabBarController.h"

@interface TPTabBarController ()

@end

@implementation TPTabBarController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

@end
