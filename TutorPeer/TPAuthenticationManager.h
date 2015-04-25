//
//  TPAuthenticationManager.h
//  TutorPeer
//
//  Created by Yondon Fu on 4/24/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPAuthenticationManager : NSObject

+ (instancetype)sharedInstance;

- (void)signUpWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email firstName:(NSString *)firstName
                  lastName:(NSString *)lastName;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password;

@end
