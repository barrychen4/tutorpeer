//
//  TPAuthenticationManager.m
//  TutorPeer
//
//  Created by Yondon Fu on 4/24/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPAuthenticationManager.h"
#import <Parse/Parse.h>

@implementation TPAuthenticationManager

+ (instancetype)sharedInstance
{
    static TPAuthenticationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TPAuthenticationManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)signUpWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email firstName:(NSString *)firstName
                  lastName:(NSString *)lastName
{
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    user.email = email;
    
    user[@"first_name"] = firstName;
    user[@"last_name"] = lastName;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Sign up successful!");
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@", errorString);
        }
    }];
}

@end