//
//  TPEditProfileViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 6/12/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPEditProfileViewController.h"
#import "TPUser.h"

@interface TPEditProfileViewController ()

@property (strong, nonatomic) TPUser *user;
@property (strong, nonatomic) UIImageView *profileImageView;
@property (strong, nonatomic) UILabel *editBioLabel;
@property (strong, nonatomic) UILabel *editNameLabel;
@property (strong, nonatomic) UILabel *editEmailLabel;

@end

@implementation TPEditProfileViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Edit Profile";
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.profileImageView.center = CGPointMake(self.view.center.x, self.view.center.y - 140);
    self.profileImageView.backgroundColor = [UIColor grayColor];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    [self.profileImageView setUserInteractionEnabled:YES];
    
    UIGestureRecognizer *profileImageRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseImage:)];
    [self.profileImageView addGestureRecognizer:profileImageRecognizer];
    
    [self.view addSubview:self.profileImageView];
}

- (void)chooseImage:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"Choose image");
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    mediaUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    mediaUI.allowsEditing = NO;
    
    mediaUI.delegate = self;
    
    [self presentViewController:mediaUI animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
}

@end
