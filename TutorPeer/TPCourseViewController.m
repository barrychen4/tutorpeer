//
//  TPCourseViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPCourseViewController.h"

@interface TPCourseViewController ()

@property (strong, nonatomic) NSString *course; // change class later
@property (strong, nonatomic) UILabel *courseLabel;

@end

@implementation TPCourseViewController

- (instancetype)initWithCourse:(NSString *)course {
    self = [super init];
    if (self) {
        _course = course;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _courseLabel = [[UILabel alloc] init];
    _courseLabel.frame = CGRectMake(20, 200, 150, 150);
    _courseLabel.text = _course;
    [self.view addSubview:_courseLabel];
}

@end
