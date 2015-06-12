//
//  TPProfileViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPProfileViewController.h"
#import "TPUser.h"
#import "TPEditProfileViewController.h"
#import <Parse/Parse.h>

@interface TPProfileViewController ()

@property (strong, nonatomic) TPUser *user;
@property (strong, nonatomic) UIImageView *profileImageView;
@property (strong, nonatomic) UILabel *bioLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *emailLabel;

@end

@implementation TPProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Profile";
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editProfile)];
    [leftBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:16.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.profileImageView.center = CGPointMake(self.view.center.x, self.view.center.y - 140);
    self.profileImageView.backgroundColor = [UIColor grayColor];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    
    [self.view addSubview:self.profileImageView];
    
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"Current user %@", currentUser);
    
    _bioLabel = [[UILabel alloc] init];
    _bioLabel.frame = CGRectMake(0, 0, 200, 50);
    _bioLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 60);
    _bioLabel.text = currentUser[@"defaultBio"];
    _bioLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    _bioLabel.numberOfLines = 2;
    _bioLabel.textAlignment = NSTextAlignmentCenter;
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(20, self.view.center.y - 20, 200, 50);
    _nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    _nameLabel.text = [NSString stringWithFormat:@"Name: %@ %@", currentUser[@"firstName"], currentUser[@"lastName"]];
    
    _emailLabel = [[UILabel alloc] init];
    _emailLabel.frame = CGRectMake(20, self.view.center.y + 20, 200, 50);
    _emailLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    _emailLabel.text = [NSString stringWithFormat:@"Email: %@", currentUser[@"email"]];
    
    [self.view addSubview:_bioLabel];
    [self.view addSubview:_nameLabel];
    [self.view addSubview:_emailLabel];
}

- (void)editProfile {
    NSLog(@"Edit button pressed");
    
    TPEditProfileViewController *editProfileVc = [[TPEditProfileViewController alloc] init];
    
    [self.navigationController pushViewController:editProfileVc animated:YES];
}

@end
