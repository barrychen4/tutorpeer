//
//  TPEditProfileViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 6/12/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPEditProfileViewController.h"
#import "TPUser.h"
#import <Parse/Parse.h>

@interface TPEditProfileViewController ()

@property (strong, nonatomic) TPUser *user;
@property (strong, nonatomic) UIImageView *profileImageView;
@property (strong, nonatomic) UITextView *editBioTextView;
@property (strong, nonatomic) UITextView *editFirstNameTextView;
@property (strong, nonatomic) UITextView *editLastNameTextView;
@property (strong, nonatomic) UITextView *editEmailTextView;

@end

@implementation TPEditProfileViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Edit Profile";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(finishEdit)];
    [rightBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:16.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.profileImageView.center = CGPointMake(self.view.center.x, self.view.center.y - 140);
    self.profileImageView.backgroundColor = [UIColor grayColor];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.profileImageView setUserInteractionEnabled:YES];
    
    UIGestureRecognizer *profileImageRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseImage:)];
    [self.profileImageView addGestureRecognizer:profileImageRecognizer];
    
    [self.view addSubview:self.profileImageView];
    
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser[@"profileImage"]) {
        PFFile *imageFile = currentUser[@"profileImage"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                self.profileImageView.image = image;
            }
        }];
    }
    
    self.editBioTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, self.view.center.y - 60, 250, 50)];
    self.editBioTextView.text = currentUser[@"defaultBio"];
    self.editBioTextView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.editBioTextView.layer.borderWidth = 1.0f;
    self.editBioTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [self.editBioTextView setReturnKeyType:UIReturnKeyDone];
    
    [self.view addSubview:self.editBioTextView];
    
    self.editFirstNameTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, self.view.center.y, 250, 50)];
    self.editFirstNameTextView.text = currentUser[@"firstName"];
    self.editFirstNameTextView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.editFirstNameTextView.layer.borderWidth = 1.0f;
    self.editFirstNameTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [self.editFirstNameTextView setReturnKeyType:UIReturnKeyDone];
    
    [self.view addSubview:self.editFirstNameTextView];
    
    self.editLastNameTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, self.view.center.y + 60, 250, 50)];
    self.editLastNameTextView.text = currentUser[@"lastName"];
    self.editLastNameTextView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.editLastNameTextView.layer.borderWidth = 1.0f;
    self.editLastNameTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [self.editLastNameTextView setReturnKeyType:UIReturnKeyDone];
    
    [self.view addSubview:self.editLastNameTextView];
    
    self.editEmailTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, self.view.center.y + 120, 250, 50)];
    self.editEmailTextView.text = currentUser[@"email"];
    self.editEmailTextView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.editEmailTextView.layer.borderWidth = 1.0f;
    self.editEmailTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [self.editEmailTextView setReturnKeyType:UIReturnKeyDone];
    
    [self.view addSubview:self.editEmailTextView];

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
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.profileImageView.image = image;
    
    NSData *imageData = UIImagePNGRepresentation(image);
    PFFile *imageFile = [PFFile fileWithName:@"ProfileImage.png" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            if (succeeded) {
                NSLog(@"Saved profile image");
                
                PFUser *user = [PFUser currentUser];
                user[@"profileImage"] = imageFile;
                
                [user saveInBackground];
            }
        }
    }];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)finishEdit
{
    PFUser *user = [PFUser currentUser];
    user[@"defaultBio"] = self.editBioTextView.text;
    user[@"firstName"] = self.editFirstNameTextView.text;
    user[@"lastName"] = self.editLastNameTextView.text;
    user[@"email"] = self.editEmailTextView.text;
    
    [user saveInBackground];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TPDoneEditingNotification" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
