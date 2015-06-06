//
//  TPLandingViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 4/20/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPLandingViewController.h"
#import "TPSignUpViewController.h"
#import "TPSignInViewController.h"

@interface TPLandingViewController ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *signUpButton;
@property (strong, nonatomic) UIButton *loginButton;

@end

@implementation TPLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    self.titleLabel.text = @"TutorPeer";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    self.titleLabel.center = CGPointMake(self.view.center.x, 155);
    
    self.signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    self.signUpButton.center = CGPointMake(self.view.center.x, 300);
    [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    self.loginButton.center = CGPointMake(self.view.center.x, 380);
    [self.loginButton setTitle:@"Log In" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.signUpButton];
    [self.view addSubview:self.loginButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)signUp {
    TPSignUpViewController *signUpVc = [[TPSignUpViewController alloc] init];
    [self.navigationController pushViewController:signUpVc animated:YES];
}

- (void)login {
    TPSignInViewController *loginVc = [[TPSignInViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

@end
