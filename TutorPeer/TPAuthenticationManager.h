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

- (void)signUpWithEmail:(NSString *)email password:(NSString *)password firstName:(NSString *)firstName
               lastName:(NSString *)lastName callback:(void (^)(BOOL))handler;

- (void)signInWithEmail:(NSString *)email password:(NSString *)password callback:(void (^)(BOOL))handler;

@end
