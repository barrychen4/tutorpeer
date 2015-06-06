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

+ (instancetype)sharedInstance {
    static TPAuthenticationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TPAuthenticationManager alloc] init];
    });
    return sharedInstance;
}

- (void)signUpWithEmail:(NSString *)email password:(NSString *)password firstName:(NSString *)firstName
               lastName:(NSString *)lastName callback:(void (^)(BOOL))handler {
    PFUser *user = [PFUser user];
    user.username = email;
    user.password = password;
    user.email = email;
    user[@"first_name"] = firstName;
    user[@"last_name"] = lastName;
    user[@"defaultPrice"] = @(15);
    user[@"defaultBio"] = [NSString stringWithFormat:@"Hi, my name is %@! Please let me be your tutor.", firstName];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Sign up successful!");
            if (handler) {
                handler(YES);
            }
        } else {
            NSLog(@"Sign up failed: %@", error);
            if (handler) {
                handler(NO);
            }
        }
    }];
}

- (void)signInWithEmail:(NSString *)email password:(NSString *)password callback:(void (^)(BOOL))handler {
    [PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error) {
        if (!error) {
            NSLog(@"Login successful!");
            if (handler) {
                handler(YES);
            }
        } else {
            NSLog(@"Login failed: %@", error);
            if (handler) {
                handler(NO);
            }
        }
    }];
}

- (void)logout {
    [PFUser logOut];
}

@end
