//
//  TPLoginViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 4/20/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPLoginViewController.h"
#import "TPAuthenticationManager.h"
#import "TPInboxViewController.h"
#import "TPCourseListViewController.h"
#import "TPProfileViewController.h"

@interface TPLoginViewController ()

@property (strong, nonatomic) UITextField *usernameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;

@property (strong, nonatomic) UIButton *loginButton;

@end

@implementation TPLoginViewController

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
    self.titleLabel.text = @"Log In";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    self.titleLabel.center = CGPointMake(self.view.center.x, 155);
    [self.view addSubview:self.titleLabel];
    
    UIView *usernamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 50)];
    self.usernameTextField.layer.cornerRadius = 5;
    self.usernameTextField.clipsToBounds = YES;
    self.usernameTextField.placeholder = @"Username";
    self.usernameTextField.backgroundColor = [UIColor whiteColor];
    self.usernameTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.usernameTextField.layer.borderWidth = 1.0f;
    self.usernameTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.usernameTextField.center = CGPointMake(self.view.center.x, self.view.center.y - 40);
    self.usernameTextField.leftView = usernamePaddingView;
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameTextField.keyboardType = UIKeyboardTypeDefault;
    [self.usernameTextField setUserInteractionEnabled:YES];
    self.usernameTextField.delegate = self;
    [self.view addSubview:self.usernameTextField];
    
    UIView *passwordPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 50)];
    [self.passwordTextField setSecureTextEntry:YES];
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.clipsToBounds = YES;
    self.passwordTextField.placeholder = @"Password";
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.passwordTextField.layer.borderWidth = 1.0f;
    self.passwordTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.center = CGPointMake(self.view.center.x, self.view.center.y + 40);
    self.passwordTextField.leftView = passwordPaddingView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.keyboardType = UIKeyboardTypeDefault;
    [self.passwordTextField setUserInteractionEnabled:YES];
    self.passwordTextField.delegate = self;
    [self.view addSubview:self.passwordTextField];
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 40)];
    [self.loginButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    self.loginButton.center = CGPointMake(self.view.center.x, self.view.center.y + 180);
    [[self.loginButton layer] setBorderWidth:1.0f];
    [[self.loginButton layer] setBorderColor:[UIColor blackColor].CGColor];
    [self.loginButton addTarget:self action:@selector(attemptLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)hideKeyboard:(id)sender {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)attemptLogin {
    [[TPAuthenticationManager sharedInstance] loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text callback:^(BOOL result) {
        if (result) {
            NSLog(@"Logged in!");
            UINavigationController *inboxViewController = [[UINavigationController alloc] initWithRootViewController:[[TPInboxViewController alloc] init]];
            UINavigationController *courseViewController = [[UINavigationController alloc] initWithRootViewController:[[TPCourseListViewController alloc] init]];
            UINavigationController *profileViewController = [[UINavigationController alloc] initWithRootViewController:[[TPProfileViewController alloc] init]];
            
            inboxViewController.title = @"Inbox";
            courseViewController.title = @"Courses";
            profileViewController.title = @"Profile";
            
            UITabBarController *tabBarController = [[UITabBarController alloc] init];

            tabBarController.viewControllers = @[inboxViewController, courseViewController, profileViewController];
            [self.navigationController pushViewController:tabBarController animated:YES];
        }
        else {
            NSLog(@"Didn't log in!");
        }
    }];
}


@end
