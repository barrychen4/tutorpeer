//
//  TPProfileView.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPProfileView.h"
#import "TPUser.h"

@interface TPProfileView ()

@property (strong, nonatomic) UILabel *nameLabel;

@end

@implementation TPProfileView

- (instancetype)initWithUser:(TPUser *)user {
    self = [super init];
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.frame = CGRectMake(20, 200, 150, 150);
        _nameLabel.text = @"User name goes here";
        [self addSubview:_nameLabel];
    }
    return self;
}

@end
