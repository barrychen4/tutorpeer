//
//  TPSignUpViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 4/20/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPSignUpViewController.h"
#import "TPAuthenticationManager.h"
#import "TPDBManager.h"
#import "TPTabBarController.h"
#import "TPInboxViewController.h"
#import "TPCourseListViewController.h"
#import "TPProfileViewController.h"
#import "TPUser.h"
#import <Parse/Parse.h>

@interface TPSignUpViewController ()

@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UITextField *firstNameTextField;
@property (strong, nonatomic) UITextField *lastNameTextField;

@end

@implementation TPSignUpViewController

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
    navItem.title = @"Sign Up";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(attemptSignUp)];
    [rightBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:16.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    navItem.rightBarButtonItem = rightBarButton;
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Light" size:21.0], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    UIView *emailPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    _emailTextField.layer.cornerRadius = 5;
    _emailTextField.clipsToBounds = YES;
    _emailTextField.placeholder = @"Email";
    _emailTextField.backgroundColor = [UIColor whiteColor];
    _emailTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    _emailTextField.layer.borderWidth = 1.0f;
    _emailTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    _emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _emailTextField.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
    _emailTextField.leftView = emailPaddingView;
    _emailTextField.leftViewMode = UITextFieldViewModeAlways;
    _emailTextField.delegate = self;
    
    
    UIView *passwordPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    [_passwordTextField setSecureTextEntry:YES];
    _passwordTextField.layer.cornerRadius = 5;
    _passwordTextField.clipsToBounds = YES;
    _passwordTextField.placeholder = @"Password";
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    _passwordTextField.layer.borderWidth = 1.0f;
    _passwordTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.center = CGPointMake(self.view.center.x, self.view.center.y - 30);
    _passwordTextField.leftView = passwordPaddingView;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.delegate = self;
    
    UIView *firstNamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    _firstNameTextField.layer.cornerRadius = 5;
    _firstNameTextField.clipsToBounds = YES;
    _firstNameTextField.placeholder = @"First Name";
    _firstNameTextField.backgroundColor = [UIColor whiteColor];
    _firstNameTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    _firstNameTextField.layer.borderWidth = 1.0f;
    _firstNameTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    _firstNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _firstNameTextField.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
    _firstNameTextField.leftView = firstNamePaddingView;
    _firstNameTextField.leftViewMode = UITextFieldViewModeAlways;
    _firstNameTextField.delegate = self;
    
    
    UIView *lastNamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    _lastNameTextField.layer.cornerRadius = 5;
    _lastNameTextField.clipsToBounds = YES;
    _lastNameTextField.placeholder = @"Last Name";
    _lastNameTextField.backgroundColor = [UIColor whiteColor];
    _lastNameTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    _lastNameTextField.layer.borderWidth = 1.0f;
    _lastNameTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    _lastNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _lastNameTextField.center = CGPointMake(self.view.center.x, self.view.center.y + 70);
    _lastNameTextField.leftView = lastNamePaddingView;
    _lastNameTextField.leftViewMode = UITextFieldViewModeAlways;
    _lastNameTextField.delegate = self;
    
    [self.view addSubview:_emailTextField];
    [self.view addSubview:_passwordTextField];
    [self.view addSubview:_firstNameTextField];
    [self.view addSubview:_lastNameTextField];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)attemptSignUp {
    NSLog(@"got here");
    [[TPAuthenticationManager sharedInstance] signUpWithEmail:self.emailTextField.text password:self.passwordTextField.text firstName:self.firstNameTextField.text lastName:self.lastNameTextField.text callback:^(BOOL result) {
        if (result) {
            [[TPDBManager sharedInstance] updateLocalUser];

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
        }
    }];
}

- (void)hideKeyboard:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
}



@end
