//
//  TPNetworkManager+CourseRequests.h
//  TutorPeer
//
//  Created by Yondon Fu on 6/16/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager.h"

@interface TPNetworkManager (CourseRequests)

- (BOOL)refreshCoursesWithCallback:(void (^)(NSError *))callback;

@end
