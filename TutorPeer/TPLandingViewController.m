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
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    _titleLabel.text = @"TutorPeer";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    _titleLabel.center = CGPointMake(self.view.center.x, 155);
    
    _signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    _signUpButton.center = CGPointMake(self.view.center.x, 300);
    [_signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [_signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_signUpButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    
    _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    _loginButton.center = CGPointMake(self.view.center.x, 380);
    [_loginButton setTitle:@"Log In" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_signUpButton];
    [self.view addSubview:_loginButton];
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
