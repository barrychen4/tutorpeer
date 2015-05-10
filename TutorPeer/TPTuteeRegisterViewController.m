//
//  TPTuteeRegisterViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPTuteeRegisterViewController.h"
#import "TPCourse.h"

@interface TPTuteeRegisterViewController()

@property (strong, nonatomic) TPCourse *course;
@property (strong, nonatomic) UITextField *priceTextField;

@end

@implementation TPTuteeRegisterViewController

- (instancetype)initWithCourse:(TPCourse *)course {
    self = [super init];
    if (self) {
        _course = course;
    }
    return self;
}

- (void)viewDidLoad {
    self.title = @"Register as tutee";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *pricePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    self.priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 20, 40)];
    self.priceTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.priceTextField.layer.cornerRadius = 5;
    self.priceTextField.clipsToBounds = YES;
    self.priceTextField.placeholder = @"Price";
    self.priceTextField.backgroundColor = [UIColor whiteColor];
    self.priceTextField.layer.borderColor = [[UIColor blackColor] CGColor];
    self.priceTextField.layer.borderWidth = 1.0f;
    self.priceTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.priceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.priceTextField.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
    self.priceTextField.leftView = pricePaddingView;
    self.priceTextField.leftViewMode = UITextFieldViewModeAlways;
    self.priceTextField.delegate = self;
    [self.view addSubview:self.priceTextField];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)hideKeyboard:(id)sender {
    [self.priceTextField resignFirstResponder];
}

@end
