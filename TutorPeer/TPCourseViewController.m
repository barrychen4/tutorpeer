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
@property (strong, nonatomic) UILabel *registeredLabel;

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
    if (![self registered]) {
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
        
        [self.view addSubview:_registerTutorButton];
        [self.view addSubview:_registerTuteeButton];
    } else {
        [_registerTutorButton removeFromSuperview];
        [_registerTuteeButton removeFromSuperview];
        _registeredLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 150, 50)];
        _registeredLabel.backgroundColor = [UIColor blueColor];
        _registeredLabel.text = @"Already registered";
        [self.view addSubview:_registeredLabel];
    }
}

- (BOOL)registered {
    return [_courseObject[@"tutors"] containsObject:[PFUser currentUser].username] || [_courseObject[@"tutees"] containsObject:[PFUser currentUser].username];
}

- (void)registerAsTutor {
    NSLog(@"Register as tutor\n");
    TPTutorRegisterViewController *tutorRegisterViewController = [[TPTutorRegisterViewController alloc] initWithPFObject:_courseObject];
    [self.navigationController pushViewController:tutorRegisterViewController animated:YES];
}

- (void)registerAsTutee {
    NSLog(@"Register as tutee\n");
    TPTuteeRegisterViewController *tuteeRegisterViewController = [[TPTuteeRegisterViewController alloc] initWithPFObject:_courseObject];
    [self.navigationController pushViewController:tuteeRegisterViewController animated:YES];
}

@end
