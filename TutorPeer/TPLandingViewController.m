//
//  TPLandingViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 4/20/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPLandingViewController.h"

@implementation TPLandingViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self setupView];
        
    }
    
    return self;
}

- (void)setupView
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    self.titleLabel.text = @"TutorPeer";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    self.titleLabel.center = CGPointMake(self.view.center.x, 155);
    [self.view addSubview:self.titleLabel];
    
    self.signUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    self.signUpLabel.text = @"Sign Up";
    self.signUpLabel.textAlignment = NSTextAlignmentCenter;
    self.signUpLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    self.signUpLabel.center = CGPointMake(self.view.center.x, 300);
    [self.view addSubview:self.signUpLabel];
    
    self.loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    self.loginLabel.text = @"Login";
    self.loginLabel.textAlignment = NSTextAlignmentCenter;
    self.loginLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    self.loginLabel.center = CGPointMake(self.view.center.x, 380);
    [self.view addSubview:self.loginLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
@end
