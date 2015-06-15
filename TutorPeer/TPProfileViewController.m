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
#import "TPSettingsViewController.h"
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
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(editSettings)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.profileImageView.center = CGPointMake(self.view.center.x, self.view.center.y - 140);
    self.profileImageView.backgroundColor = [UIColor grayColor];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:self.profileImageView];
    
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"Current user %@", currentUser);
    
    self.bioLabel = [[UILabel alloc] init];
    self.bioLabel.frame = CGRectMake(0, 0, 200, 50);
    self.bioLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 60);
    self.bioLabel.text = currentUser[@"defaultBio"];
    self.bioLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    self.bioLabel.numberOfLines = 2;
    self.bioLabel.textAlignment = NSTextAlignmentCenter;
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.frame = CGRectMake(20, self.view.center.y - 20, 200, 50);
    self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.nameLabel.text = [NSString stringWithFormat:@"Name: %@ %@", currentUser[@"firstName"], currentUser[@"lastName"]];
    
    self.emailLabel = [[UILabel alloc] init];
    self.emailLabel.frame = CGRectMake(20, self.view.center.y + 20, 200, 50);
    self.emailLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    self.emailLabel.text = [NSString stringWithFormat:@"Email: %@", currentUser[@"email"]];
    
    if (currentUser[@"profileImage"]) {
        PFFile *imageFile = currentUser[@"profileImage"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                self.profileImageView.image = image;
            }
        }];
    }
    
    [self.view addSubview:self.bioLabel];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.emailLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneEditing) name:@"TPDoneEditingNotification" object:nil];
}

- (void)editProfile {
    NSLog(@"Edit button pressed");
    
    TPEditProfileViewController *editProfileVc = [[TPEditProfileViewController alloc] init];
    
    [self.navigationController pushViewController:editProfileVc animated:YES];
}

- (void)editSettings {
    NSLog(@"Edit settings pressed");
    
    TPSettingsViewController *settingsVc = [[TPSettingsViewController alloc] init];
    
    [self.navigationController pushViewController:settingsVc animated:YES];
}

- (void)doneEditing
{
    PFUser *currentUser = [PFUser currentUser];
    self.bioLabel.text = currentUser[@"defaultBio"];
    self.nameLabel.text = [NSString stringWithFormat:@"Name: %@ %@", currentUser[@"firstName"], currentUser[@"lastName"]];
    self.emailLabel.text = [NSString stringWithFormat:@"Email: %@", currentUser[@"email"]];
    if (currentUser[@"profileImage"]) {
        PFFile *imageFile = currentUser[@"profileImage"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                self.profileImageView.image = image;
            }
        }];
    }
}

@end
