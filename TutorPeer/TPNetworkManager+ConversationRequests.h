//
//  TPNetworkManager+ConversationRequests.h
//  TutorPeer
//
//  Created by Yondon Fu on 6/17/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager.h"
#import "TPConversation.h"

@interface TPNetworkManager (ConversationRequests)

- (void)refreshConversationsForUserId:(NSString *)userId withCallback:(void (^)(NSError *error))callback;
- (void)createConversationForContract:(NSString *)contractId withTutor:(NSString *)tutorId withTutee:(NSString *)tuteeId withCallback:(void (^)(NSError *))callback;

@end
