//
//  TPCourseView.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPCourseView.h"

@interface TPCourseView()

@property (strong, nonatomic) UILabel *courseLabel;

@end

@implementation TPCourseView

- (instancetype)initWithCourse:(NSString *)course {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _courseLabel = [[UILabel alloc] init];
        _courseLabel.frame = CGRectMake(20, 200, 150, 150);
        _courseLabel.text = course;
        [self addSubview:_courseLabel];
    }
    return self;
}

@end
