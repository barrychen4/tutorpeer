//
//  TPNetworkManager+ConversationRequests.m
//  TutorPeer
//
//  Created by Yondon Fu on 6/17/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager+ConversationRequests.h"
#import "TPNetworkManager+ContractRequests.h"
#import "TPDBManager.h"
#import "TPConversation.h"
#import <Parse/Parse.h>

@implementation TPNetworkManager (ConversationRequests)

- (void)refreshConversationsForUserId:(NSString *)userId withCallback:(void (^)(NSError *error))callback
{
    [[TPNetworkManager sharedInstance] refreshContractsForUserId:userId withCallback:^(NSArray *objects, NSError *error) {
        NSLog(@"%@", objects);
        for (NSString *contractId in objects) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(contract == %@)", contractId];
            PFQuery *query = [PFQuery queryWithClassName:@"Conversation" predicate:predicate];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    if (!objects.count) {
                        PFObject *contractPFObject = [PFQuery getObjectOfClass:@"Contract" objectId:contractId];
                        [[TPNetworkManager sharedInstance] createConversationForContract:contractId withTutor:contractPFObject[@"tutor"] withTutee:contractPFObject[@"tutee"] withCallback:nil];
                    } else {
                        PFObject *conversationPFObject = objects[0];
                        [[TPDBManager sharedInstance] addLocalObjectForDBClass:@"TPConversation" withRemoteObject:conversationPFObject];
                        NSLog(@"Added conversation locally after finding pfobject");
                    }
                } else {
                    if (callback) {
                        callback(error);
                    }
                }
            }];
        }
        
        if (callback) {
            callback(nil);
        }
    }];
    
}

- (void)createConversationForContract:(NSString *)contractId withTutor:(NSString *)tutorId withTutee:(NSString *)tuteeId withCallback:(void (^)(NSError *))callback
{
    PFObject *contractObject = [PFQuery getObjectOfClass:@"Contract" objectId:contractId];
    if (!contractObject) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The contract for this id doesn't exist.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check for a valid contract id.", nil)
                                   };
        
        NSError *idError = [NSError errorWithDomain:@"TutorEntryError" code:800 userInfo:userInfo];
        
        if (callback) {
            callback(idError);
        }
    } else {
        PFObject *conversationPFObject = [PFObject objectWithClassName:@"Conversation"];
        conversationPFObject[@"contract"] = contractId;
        conversationPFObject[@"tutor"] = tutorId;
        conversationPFObject[@"tutee"] = tuteeId;
        
        [conversationPFObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                if (succeeded) {
                    NSMutableArray *userConversations = [NSMutableArray arrayWithArray:[PFUser currentUser][@"conversations"]];
                    if (![userConversations containsObject:conversationPFObject]) {
                        [userConversations addObject:conversationPFObject.objectId];
                    }
                    
                    [PFUser currentUser][@"conversations"] = userConversations;
                    
                    contractObject[@"conversation"] = conversationPFObject.objectId;
                    
                    NSError *saveError;
                    [PFObject saveAll:@[[PFUser currentUser], contractObject] error:&saveError];
                    
                    if (saveError) {
                        if (callback) {
                            callback(saveError);
                        }
                    }
                
                    [[TPDBManager sharedInstance] addLocalObjectForDBClass:@"TPConversation" withRemoteObject:conversationPFObject];
                    NSLog(@"Added conversation locally after creating it");
                    
                } else {
                    
                }
            } else {
                if (callback) {
                    callback(error);
                }
            }
        }];

    }
}

@end
