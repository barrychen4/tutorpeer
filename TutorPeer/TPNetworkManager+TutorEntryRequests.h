//
//  TPNetworkManager+TutorEntryRequests.h
//  TutorPeer
//
//  Created by Yondon Fu on 6/16/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager.h"

@interface TPNetworkManager (TutorEntryRequests)

- (void)refreshTutorEntriesForCourseId:(NSString *)courseId withCallback:(void (^)(NSError *))callback;
- (void)registerAsTutorForCourseId:(NSString *)courseId withPrice:(NSInteger)price withBlurb:(NSString *)blurb withCallback:(void (^)(NSError *))callback;
- (void)updateTutorEntryWithId:(NSString *)tutorEntryId withPrice:(NSInteger)price withBlurb:(NSString *)blurb withCallback:(void (^)(NSError *))callback;
- (void)unregisterAsTutorWithId:(NSString *)tutorEntryId forCourseId:(NSString *)courseId withCallback:(void (^)(NSError *))callback;
- (void)registerAsTutee:(NSString *)tuteeId withTutor:(NSString *)tutorId forCourse:(NSString *)courseId withPrice:(NSInteger)price withCallback:(void (^)(NSError *))callback;
- (void)unregisterAsTuteeForCourse:(NSString *)courseId forContract:(NSString *)contractId withCallback:(void (^)(NSError *))callback;

@end
