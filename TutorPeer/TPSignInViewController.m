//
//  TPLoginViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 4/20/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPSignInViewController.h"
#import "TPAuthenticationManager.h"
#import "TPDBManager.h"
#import "TPNetworkManager.h"
#import "TPTabBarController.h"
#import "TPInboxViewController.h"
#import "TPCourseListViewController.h"
#import "TPProfileViewController.h"
#import <Parse/Parse.h>

@interface TPSignInViewController ()

@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UILabel *failedSignInLabel;

@end

@implementation TPSignInViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"Sign In";
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(attemptSignIn)];
    [rightBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:16.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    navItem.rightBarButtonItem = rightBarButton;
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Light" size:21.0], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];

    
    UIView *emailPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 50)];
    _emailTextField.layer.cornerRadius = 5;
    _emailTextField.clipsToBounds = YES;
    _emailTextField.placeholder = @"Username";
    _emailTextField.backgroundColor = [UIColor whiteColor];
    _emailTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    _emailTextField.layer.borderWidth = 1.0f;
    _emailTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    _emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _emailTextField.center = CGPointMake(self.view.center.x, self.view.center.y - 40);
    _emailTextField.leftView = emailPaddingView;
    _emailTextField.leftViewMode = UITextFieldViewModeAlways;
    _emailTextField.keyboardType = UIKeyboardTypeDefault;
    [_emailTextField setUserInteractionEnabled:YES];
    _emailTextField.delegate = self;
    
    [self.view addSubview:_emailTextField];
    
    UIView *passwordPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 50)];
    [_passwordTextField setSecureTextEntry:YES];
    _passwordTextField.layer.cornerRadius = 5;
    _passwordTextField.clipsToBounds = YES;
    _passwordTextField.placeholder = @"Password";
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    _passwordTextField.layer.borderWidth = 1.0f;
    _passwordTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.center = CGPointMake(self.view.center.x, self.view.center.y + 40);
    _passwordTextField.leftView = passwordPaddingView;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.keyboardType = UIKeyboardTypeDefault;
    [_passwordTextField setUserInteractionEnabled:YES];
    _passwordTextField.delegate = self;
    
    [self.view addSubview:_passwordTextField];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
    
    _failedSignInLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 50)];
    _failedSignInLabel.text = @"Invalid email or password. Please try again.";
    _failedSignInLabel.numberOfLines = 2;
    _failedSignInLabel.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    _failedSignInLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [_failedSignInLabel setHidden:YES];
    
    [self.view addSubview:_failedSignInLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)hideKeyboard:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)attemptSignIn {
//    [[TPAuthenticationManager sharedInstance] signInWithEmail:self.emailTextField.text password:self.passwordTextField.text callback:^(BOOL result) {
    [[TPAuthenticationManager sharedInstance] signInWithEmail:@"y.fu710@gmail.com" password:@"test" callback:^(BOOL result) {
        if (result) {
            [[TPDBManager sharedInstance] updateLocalUser];
            [[TPNetworkManager sharedInstance] refreshContractsForUserId:[PFUser currentUser].objectId withCallback:nil async:YES];
            
            UINavigationController *inboxViewController = [[UINavigationController alloc] initWithRootViewController:[[TPInboxViewController alloc] init]];
            UINavigationController *courseViewController = [[UINavigationController alloc] initWithRootViewController:[[TPCourseListViewController alloc] init]];
            UINavigationController *profileViewController = [[UINavigationController alloc] initWithRootViewController:[[TPProfileViewController alloc] init]];
            
            inboxViewController.title = @"Inbox";
            courseViewController.title = @"Courses";
            profileViewController.title = @"Profile";
            
            TPTabBarController *tabBarController = [[TPTabBarController alloc] init];
            
            tabBarController.viewControllers = @[inboxViewController, courseViewController, profileViewController];
            tabBarController.selectedIndex = 1;
            [self.navigationController pushViewController:tabBarController animated:YES];
        } else {
            [self.failedSignInLabel setHidden:NO];
        }
    }];
}

@end
