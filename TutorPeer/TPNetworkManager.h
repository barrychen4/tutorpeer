//
//  TPNetworkManager+TPCourseRequests.h
//  TutorPeer
//
//  Created by Yondon Fu on 5/10/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TPTutorEntry;

@interface TPNetworkManager : NSObject

+ (instancetype)sharedInstance;

- (void)allParseObjectIDsForPFClass:(NSString *)pfClassName withCallback:(void (^)(NSArray *, NSError *))callback;
- (void)allParseObjectIDsForPFClass:(NSString *)pfClassName predicate:(NSPredicate *)predicate withCallback:(void (^)(NSArray *, NSError *))callback;


@end
