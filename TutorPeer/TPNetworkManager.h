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

- (BOOL)refreshCoursesWithCallback:(void (^)(NSError *))callback async:(BOOL)async;
- (BOOL)refreshTutorEntriesForCourseId:(NSString *)courseId withCallback:(void (^)(NSError *))callback async:(BOOL)async;
- (BOOL)refreshContractsForUserId:(NSString *)userId withCallback:(void (^)(NSError *))callback async:(BOOL)async;

@end
