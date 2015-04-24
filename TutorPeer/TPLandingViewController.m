//
//  TPLandingViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 4/20/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPLandingViewController.h"
#import "TPSignUpViewController.h"
#import "TPLoginViewController.h"

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
    [self.signUpLabel setUserInteractionEnabled:YES];
    [self.view addSubview:self.signUpLabel];
    
    UITapGestureRecognizer *signUpTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signUp:)];
    [self.signUpLabel addGestureRecognizer:signUpTapGesture];
    
    self.loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    self.loginLabel.text = @"Login";
    self.loginLabel.textAlignment = NSTextAlignmentCenter;
    self.loginLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    self.loginLabel.center = CGPointMake(self.view.center.x, 380);
    [self.loginLabel setUserInteractionEnabled:YES];
    [self.view addSubview:self.loginLabel];
    
    UITapGestureRecognizer *loginTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login:)];
    [self.loginLabel addGestureRecognizer:loginTapGesture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)signUp:(UITapGestureRecognizer *)recognizer
{
    TPSignUpViewController *signUpVc = [[TPSignUpViewController alloc] init];
    [self.navigationController pushViewController:signUpVc animated:NO];
}

- (void)login:(UITapGestureRecognizer *)recognizer
{
    TPLoginViewController *loginVc = [[TPLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:NO];
}

@end
