//
//  TPProfileView.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPProfileView.h"

@interface TPProfileView ()

@property (strong, nonatomic) UILabel *nameLabel;

@end

@implementation TPProfileView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.frame = CGRectMake(20, 200, frame.size.width, 150);
        _nameLabel.text = @"My name goes here";
        [self addSubview:_nameLabel];
    }
    return self;
}

@end
