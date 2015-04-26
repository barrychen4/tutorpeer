//
//  TPProfileViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPProfileViewController.h"
#import "TPProfileView.h"

@interface TPProfileViewController ()

@end

@implementation TPProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Profile";
    self.view = [[TPProfileView alloc] initWithFrame:self.view.frame];
}

@end
