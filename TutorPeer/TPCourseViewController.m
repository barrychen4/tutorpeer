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
#import <Parse/Parse.h>

@interface TPCourseViewController ()

@property (strong, nonatomic) TPCourse *course;
@property (strong, nonatomic) PFObject *courseObject;
@property (strong, nonatomic) UILabel *courseLabel;
@property (strong, nonatomic) UILabel *tutorsLabel;
@property (strong, nonatomic) UIButton *registerTutorButton;
@property (strong, nonatomic) UIButton *registerTuteeButton;
@property (strong, nonatomic) UIButton *viewRegistrationDetailsButton;

@end

@implementation TPCourseViewController

- (instancetype)initWithCourse:(TPCourse *)course {
    self = [super init];
    if (self) {
        _course = course;
    }
    return self;
}

- (instancetype)initWithPFObject:(PFObject *)courseObject {
    self = [super init];
    if (self) {
        _courseObject = courseObject;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = _course.courseName;
    self.title = _courseObject[@"courseName"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _courseLabel = [[UILabel alloc] init];
    _courseLabel.frame = CGRectMake(20, 100, 300, 50);
//    _courseLabel.text = [NSString stringWithFormat:@"Course name: %@", _course.courseName];
    _courseLabel.text = [NSString stringWithFormat:@"Course name: %@", _courseObject[@"courseName"]];
    [self.view addSubview:_courseLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _tutorsLabel = [[UILabel alloc] init];
    _tutorsLabel.frame = CGRectMake(20, 200, 400, 50);
    _tutorsLabel.text = [NSString stringWithFormat:@"Tutors: %@", [_courseObject[@"tutors"] componentsJoinedByString:@", "]];
    [self.view addSubview:_tutorsLabel];
    if ([self registeredAsTutor] || [self registeredAsTutee]) {
        [_registerTutorButton removeFromSuperview];
        [_registerTuteeButton removeFromSuperview];
        _viewRegistrationDetailsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        _viewRegistrationDetailsButton.center = CGPointMake(self.view.center.x, 300);
        [_viewRegistrationDetailsButton setTitle:@"Already registered" forState:UIControlStateNormal];
        [_viewRegistrationDetailsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_viewRegistrationDetailsButton addTarget:self action:@selector(viewDetails) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_viewRegistrationDetailsButton];
    } else {
        [_viewRegistrationDetailsButton removeFromSuperview];
        _registerTutorButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        _registerTutorButton.center = CGPointMake(self.view.center.x, 300);
        [_registerTutorButton setTitle:@"Register As Tutor" forState:UIControlStateNormal];
        [_registerTutorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerTutorButton addTarget:self action:@selector(registerAsTutor) forControlEvents:UIControlEventTouchUpInside];
        
        _registerTuteeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        _registerTuteeButton.center = CGPointMake(self.view.center.x, 400);
        [_registerTuteeButton setTitle:@"Register As Tutee" forState:UIControlStateNormal];
        [_registerTuteeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerTuteeButton addTarget:self action:@selector(registerAsTutee) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_registerTutorButton];
        [self.view addSubview:_registerTuteeButton];
    }
}

- (BOOL)registeredAsTutor {
    return [_courseObject[@"tutors"] containsString:[PFUser currentUser].username];
}

- (BOOL)registeredAsTutee {
    return [_courseObject[@"tutees"] containsString:[PFUser currentUser].username];
}

- (void)registerAsTutor {
    TPTutorRegisterViewController *tutorRegisterViewController = [[TPTutorRegisterViewController alloc] initWithPFObject:_courseObject];
    [self.navigationController pushViewController:tutorRegisterViewController animated:YES];
}

- (void)registerAsTutee {
    TPTuteeRegisterViewController *tuteeRegisterViewController = [[TPTuteeRegisterViewController alloc] initWithPFObject:_courseObject];
    [self.navigationController pushViewController:tuteeRegisterViewController animated:YES];
}

- (void)viewDetails {
    if ([self registeredAsTutor]) [self registerAsTutor];
    else [self registerAsTutee];
}

@end
