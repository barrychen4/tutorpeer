//
//  TPNetworkManager+TPCourseRequests.h
//  TutorPeer
//
//  Created by Yondon Fu on 5/10/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager.h"

@interface TPNetworkManager (TPCourseRequests)

- (void)getCoursesWithCallback:(void (^)(NSArray *))callback;

@end
