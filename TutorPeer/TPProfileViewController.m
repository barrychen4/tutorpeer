//
//  TPProfileViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPProfileViewController.h"
#import "TPUser.h"
#import <Parse/Parse.h>

@interface TPProfileViewController ()

@property (strong, nonatomic) TPUser *user;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *emailLabel;
@end

@implementation TPProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editProfile)];
    [leftBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:16.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"Current user %@", currentUser);
    self.title = @"Profile";
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(20, 200, 200, 150);
    _nameLabel.text = [NSString stringWithFormat:@"Name: %@ %@", currentUser[@"firstName"], currentUser[@"lastName"]];
    
    _emailLabel = [[UILabel alloc] init];
    _emailLabel.frame = CGRectMake(20, 300, 200, 300);
    _emailLabel.text = [NSString stringWithFormat:@"Email: %@", currentUser[@"email"]];
    [self.view addSubview:_nameLabel];
    [self.view addSubview:_emailLabel];
}

- (void)editProfile {
    NSLog(@"Edit button pressed");
}

@end
