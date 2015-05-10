//
//  TPCourseViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPCourseViewController.h"
#import "TPCourse.h"
#import "TPTutorRegisterViewController.h"
#import "TPTuteeRegisterViewController.h"

@interface TPCourseViewController ()

@property (strong, nonatomic) TPCourse *course;
@property (strong, nonatomic) UILabel *courseLabel;
@property (strong, nonatomic) UIButton *registerTutorButton;
@property (strong, nonatomic) UIButton *registerTuteeButton;

@end

@implementation TPCourseViewController

- (instancetype)initWithCourse:(TPCourse *)course {
    self = [super init];
    if (self) {
        _course = course;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _course.courseName;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _courseLabel = [[UILabel alloc] init];
    _courseLabel.frame = CGRectMake(20, 200, 300, 150);
    _courseLabel.text = [NSString stringWithFormat:@"Course name: %@", _course.courseName];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    static BOOL registered = NO;
    if (!registered) {
        NSLog(@"Registered %d", registered);
        _registerTutorButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 150, 50)];
        _registerTutorButton.backgroundColor = [UIColor blueColor];
        [_registerTutorButton setTitle:@"Register As Tutor" forState:UIControlStateNormal];
        [_registerTutorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerTutorButton addTarget:self action:@selector(registerAsTutor) forControlEvents:UIControlEventTouchUpInside];
        
        _registerTuteeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, 150, 50)];
        _registerTuteeButton.backgroundColor = [UIColor blueColor];
        [_registerTuteeButton setTitle:@"Register As Tutee" forState:UIControlStateNormal];
        [_registerTuteeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerTuteeButton addTarget:self action:@selector(registerAsTutee) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_courseLabel];
        [self.view addSubview:_registerTutorButton];
        [self.view addSubview:_registerTuteeButton];
        registered = YES;
    }
}

- (void)registerAsTutor {
    NSLog(@"Register as tutor\n");
    TPTutorRegisterViewController *tutorRegisterViewController = [[TPTutorRegisterViewController alloc] initWithCourse:_course];
    [self.navigationController pushViewController:tutorRegisterViewController animated:YES];
}

- (void)registerAsTutee {
    NSLog(@"Register as tutee\n");
    TPTuteeRegisterViewController *tuteeRegisterViewController = [[TPTuteeRegisterViewController alloc] initWithCourse:_course];
    [self.navigationController pushViewController:tuteeRegisterViewController animated:YES];
}

@end
