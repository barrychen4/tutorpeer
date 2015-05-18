//
//  TPNetworkManager+TPCourseRequests.h
//  TutorPeer
//
//  Created by Yondon Fu on 5/10/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager.h"

@import CoreData;

@interface TPNetworkManager (TPCourseRequests)

- (void)getCoursesWithCallback:(void (^)(NSArray *))callback;
- (void)getTutorEntryFor:(NSString *)username andCourse:(NSString *)courseCode withCallback:(void (^)(NSArray *))callback;
- (void)getTuteeEntryFor:(NSString *)username andCourse:(NSString *)courseCode andTutor:(NSString *)tutor withCallback:(void (^)(NSArray *))callback;

@end
