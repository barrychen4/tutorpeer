//
//  TPNetworkManager+ConversationRequests.h
//  TutorPeer
//
//  Created by Yondon Fu on 6/17/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager.h"

@interface TPNetworkManager (ConversationRequests)

- (void)createConversationForContract:(NSString *)contractId withTutor:(NSString *)tutorId withTutee:(NSString *)tuteeId withCallback:(void (^)(NSError *))callback;

@end
