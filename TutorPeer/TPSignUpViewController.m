//
//  TPSignUpViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 4/20/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPSignUpViewController.h"
#import "TPAuthenticationManager.h"
#import "TPTabBarController.h"
#import "TPInboxViewController.h"
#import "TPCourseListViewController.h"
#import "TPProfileViewController.h"
#import "TPUser.h" 

@interface TPSignUpViewController ()

@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UITextField *firstNameTextField;
@property (strong, nonatomic) UITextField *lastNameTextField;

@end

@implementation TPSignUpViewController

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
    navItem.title = @"Sign Up";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:nil action:@selector(attemptSignUp)];
    [rightBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:16.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    navItem.rightBarButtonItem = rightBarButton;
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Light" size:21.0], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    
    UIView *emailPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    self.emailTextField.layer.cornerRadius = 5;
    self.emailTextField.clipsToBounds = YES;
    self.emailTextField.placeholder = @"Email";
    self.emailTextField.backgroundColor = [UIColor whiteColor];
    self.emailTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.emailTextField.layer.borderWidth = 1.0f;
    self.emailTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.emailTextField.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
    self.emailTextField.leftView = emailPaddingView;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    self.emailTextField.delegate = self;
    [self.view addSubview:self.emailTextField];
    
    UIView *passwordPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    [self.passwordTextField setSecureTextEntry:YES];
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.clipsToBounds = YES;
    self.passwordTextField.placeholder = @"Password";
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.passwordTextField.layer.borderWidth = 1.0f;
    self.passwordTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.center = CGPointMake(self.view.center.x, self.view.center.y - 30);
    self.passwordTextField.leftView = passwordPaddingView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.delegate = self;
    [self.view addSubview:self.passwordTextField];
    
    
    UIView *firstNamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    self.firstNameTextField.layer.cornerRadius = 5;
    self.firstNameTextField.clipsToBounds = YES;
    self.firstNameTextField.placeholder = @"First Name";
    self.firstNameTextField.backgroundColor = [UIColor whiteColor];
    self.firstNameTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.firstNameTextField.layer.borderWidth = 1.0f;
    self.firstNameTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.firstNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.firstNameTextField.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
    self.firstNameTextField.leftView = firstNamePaddingView;
    self.firstNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.firstNameTextField.delegate = self;
    [self.view addSubview:self.firstNameTextField];
    
    UIView *lastNamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    self.lastNameTextField.layer.cornerRadius = 5;
    self.lastNameTextField.clipsToBounds = YES;
    self.lastNameTextField.placeholder = @"Last Name";
    self.lastNameTextField.backgroundColor = [UIColor whiteColor];
    self.lastNameTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.lastNameTextField.layer.borderWidth = 1.0f;
    self.lastNameTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.lastNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.lastNameTextField.center = CGPointMake(self.view.center.x, self.view.center.y + 70);
    self.lastNameTextField.leftView = lastNamePaddingView;
    self.lastNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.lastNameTextField.delegate = self;
    [self.view addSubview:self.lastNameTextField];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)attemptSignUp
{
    NSLog(@"Attempt sign up");
    [[TPAuthenticationManager sharedInstance] signUpWithEmail:self.emailTextField.text password:self.passwordTextField.text firstName:self.firstNameTextField.text lastName:self.lastNameTextField.text callback:^(BOOL result) {
        if (result) {
            NSLog(@"Logged in!");
            
            TPUser *user = [[TPUser alloc] init];
            user.name = @"Ethan Yu";
            
            UINavigationController *inboxViewController = [[UINavigationController alloc] initWithRootViewController:[[TPInboxViewController alloc] init]];
            UINavigationController *courseViewController = [[UINavigationController alloc] initWithRootViewController:[[TPCourseListViewController alloc] init]];
            UINavigationController *profileViewController = [[UINavigationController alloc] initWithRootViewController:[[TPProfileViewController alloc] initWithUser:user]];
            
            inboxViewController.title = @"Inbox";
            courseViewController.title = @"Courses";
            profileViewController.title = @"Profile";
            
            TPTabBarController *tabBarController = [[TPTabBarController alloc] init];
            tabBarController.viewControllers = @[inboxViewController, courseViewController, profileViewController];
            tabBarController.selectedIndex = 1;
            [self.navigationController pushViewController:tabBarController animated:YES];
        }
        else {
            NSLog(@"Didn't log in!");
        }}];
}

- (void)hideKeyboard:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
}



@end
