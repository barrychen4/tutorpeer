//
//  TPSignUpViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 4/20/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPSignUpViewController.h"
#import "TPAuthenticationManager.h"

@interface TPSignUpViewController ()

@property (strong, nonatomic) UITextField *usernameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UITextField *firstNameTextField;
@property (strong, nonatomic) UITextField *lastNameTextField;

@property (strong, nonatomic) UIButton *signUpButton;

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
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    self.titleLabel.text = @"Sign Up";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:32];
    self.titleLabel.center = CGPointMake(self.view.center.x, 155);
    [self.view addSubview:self.titleLabel];
    
    UIView *usernamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    self.usernameTextField.layer.cornerRadius = 5;
    self.usernameTextField.clipsToBounds = YES;
    self.usernameTextField.placeholder = @"Username";
    self.usernameTextField.backgroundColor = [UIColor whiteColor];
    self.usernameTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.usernameTextField.layer.borderWidth = 1.0f;
    self.usernameTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.usernameTextField.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
    self.usernameTextField.leftView = usernamePaddingView;
    self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameTextField.delegate = self;
    [self.view addSubview:self.usernameTextField];
    
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
    self.emailTextField.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
    self.emailTextField.leftView = emailPaddingView;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    self.emailTextField.delegate = self;
    [self.view addSubview:self.emailTextField];
    
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
    self.firstNameTextField.center = CGPointMake(self.view.center.x, self.view.center.y + 70);
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
    self.lastNameTextField.center = CGPointMake(self.view.center.x, self.view.center.y + 120);
    self.lastNameTextField.leftView = lastNamePaddingView;
    self.lastNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.lastNameTextField.delegate = self;
    [self.view addSubview:self.lastNameTextField];
    
    self.signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 100, 40)];
    [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.signUpButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    self.signUpButton.center = CGPointMake(self.view.center.x, self.view.center.y + 180);
    [[self.signUpButton layer] setBorderWidth:1.0f];
    [[self.signUpButton layer] setBorderColor:[UIColor blackColor].CGColor];
    [self.signUpButton addTarget:self action:@selector(attemptSignUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signUpButton];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)attemptSignUp
{
    [[TPAuthenticationManager sharedInstance] signUpWithUsername:self.usernameTextField.text password:self.passwordTextField.text email:self.emailTextField.text firstName:self.firstNameTextField.text lastName:self.lastNameTextField.text];
}

- (void)hideKeyboard:(id)sender {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
}



@end
