//
//  TPNetworkManager+TPCourseRequests.h
//  TutorPeer
//
//  Created by Yondon Fu on 5/10/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPNetworkManager.h"

@class TPTutorEntry;

@interface TPNetworkManager : NSObject

+ (instancetype)sharedInstance;

- (void)getCoursesWithCallback:(void (^)(NSArray *))callback delta:(BOOL)delta;
- (void)getTutorEntriesForCourseId:(NSString *)courseId withCallback:(void (^)(NSArray *))callback delta:(BOOL)delta;
- (void)allParseObjectIDsForPFClass:(NSString *)pfClassName withCallback:(void (^)(NSArray *))callback;

@end
