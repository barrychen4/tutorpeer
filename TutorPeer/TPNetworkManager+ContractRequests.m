//
//  TPNetworkManager+ContractRequests.m
//  TutorPeer
//
//  Created by Yondon Fu on 6/16/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager+ContractRequests.h"
#import "TPDBManager.h"
#import <Parse/Parse.h>

@implementation TPNetworkManager (ContractRequests)

- (void)refreshContractsForUserId:(NSString *)userId withCallback:(void (^)(NSError *))callback
{
    PFQuery *query;
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(tutor.objectId == %@) OR (tutee.objectId == %@)", userId, userId];
    NSDate *latestDate = [[TPDBManager sharedInstance] latestDateForDBClass:@"TPContract" predicate:predicate1];
    NSPredicate *predicate2;
    if (latestDate) {
        predicate2 = [NSPredicate predicateWithFormat:@"((tutor == %@) OR (tutee == %@)) AND (updatedAt > %@)", userId, userId, latestDate];
    } else {
        predicate2 = [NSPredicate predicateWithFormat:@"(tutor == %@) OR (tutee == %@)", userId, userId];
    }
    query = [PFQuery queryWithClassName:@"Contract" predicate:predicate2];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error getting Parse contracts: %@", error);
            if (callback) {
                callback(error);
            }
        } else {
            BOOL gotNewObjects = NO;
            if ([objects count]) {
                [[TPDBManager sharedInstance] addLocalObjectsForDBClass:@"TPContract" withRemoteObjects:objects];
                NSLog(@"Got %lu contracts", [objects count]);
                gotNewObjects = YES;
            }
            NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"(tutor == %@) OR (tutee == %@)", userId, userId];
            [self allParseObjectIDsForPFClass:@"Contract" predicate:predicate3 withCallback:^(NSArray *objectIDArray, NSError *error) {
                if (objectIDArray) {
                    NSPredicate *predicate4 = [NSPredicate predicateWithFormat:@"(tutor.objectId == %@) OR (tutee.objectId == %@)", userId, userId];
                    [[TPDBManager sharedInstance] removeLocalObjectsNotOnParseForDBClass:@"TPContract" parseObjectIDs:objectIDArray predicate:predicate4];
                }
                if (callback) {
                    callback(nil);
                }
            }];
        }
    }];

}

@end
