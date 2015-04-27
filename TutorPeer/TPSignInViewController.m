//
//  TPLoginViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 4/20/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPSignInViewController.h"
#import "TPAuthenticationManager.h"
#import "TPInboxViewController.h"
#import "TPCourseListViewController.h"
#import "TPProfileViewController.h"

@interface TPSignInViewController ()

@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UITextField *passwordTextField;

@end

@implementation TPSignInViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"Sign In";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:nil action:@selector(attemptSignIn)];
    [rightBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:16.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    navItem.rightBarButtonItem = rightBarButton;
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Light" size:21.0], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];

    
    UIView *emailPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 50)];
    self.emailTextField.layer.cornerRadius = 5;
    self.emailTextField.clipsToBounds = YES;
    self.emailTextField.placeholder = @"Username";
    self.emailTextField.backgroundColor = [UIColor whiteColor];
    self.emailTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.emailTextField.layer.borderWidth = 1.0f;
    self.emailTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.emailTextField.center = CGPointMake(self.view.center.x, self.view.center.y - 40);
    self.emailTextField.leftView = emailPaddingView;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    self.emailTextField.keyboardType = UIKeyboardTypeDefault;
    [self.emailTextField setUserInteractionEnabled:YES];
    self.emailTextField.delegate = self;
    [self.view addSubview:self.emailTextField];
    
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
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)viewDidLoad
{
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
    [[TPAuthenticationManager sharedInstance] signInWithEmail:self.emailTextField.text password:self.passwordTextField.text callback:^(BOOL result) {
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
