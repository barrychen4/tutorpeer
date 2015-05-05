//
//  TPProfileViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPProfileViewController.h"
#import "TPUser.h"

@interface TPProfileViewController ()

@property (strong, nonatomic) TPUser *user;
@property (strong, nonatomic) UILabel *nameLabel;

@end

@implementation TPProfileViewController

- (instancetype)initWithUser:(TPUser *)user {
    self = [super init];
    if (self) {
        _user = user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Profile";
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(20, 200, 200, 150);
    _nameLabel.text = [NSString stringWithFormat:@"My name is: %@", _user.firstName];
    [self.view addSubview:_nameLabel];
}

@end
