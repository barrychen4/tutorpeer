//
//  TPNetworkManager+TutorEntryRequests.m
//  TutorPeer
//
//  Created by Yondon Fu on 6/16/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager+TutorEntryRequests.h"
#import "TPDBManager.h"
#import <Parse/Parse.h>

@implementation TPNetworkManager (TutorEntryRequests)

- (BOOL)refreshTutorEntriesForCourseId:(NSString *)courseId withCallback:(void (^)(NSError *))callback
{
    PFQuery *query;
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"course.objectId == %@", courseId];
    NSDate *latestDate = [[TPDBManager sharedInstance] latestDateForDBClass:@"TPTutorEntry" predicate:predicate1];
    NSPredicate *predicate2;
    if (latestDate) {
        predicate2 = [NSPredicate predicateWithFormat:@"(course == %@) AND (updatedAt > %@)", courseId, latestDate];
    } else {
        predicate2 = [NSPredicate predicateWithFormat:@"course == %@", courseId];
    }
    query = [PFQuery queryWithClassName:@"TutorEntry" predicate:predicate2];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error getting Parse tutor entries: %@", error);
            if (callback) {
                callback(error);
            }
        } else {
            if ([objects count]) {
                [[TPDBManager sharedInstance] addLocalObjectsForDBClass:@"TPTutorEntry" withRemoteObjects:objects];
                NSLog(@"Got %lu new tutor entries", [objects count]);
            }
            NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"course == %@", courseId];
            [self allParseObjectIDsForPFClass:@"TutorEntry" predicate:predicate3 withCallback:^(NSArray *objectIDArray, NSError *error) {
                if (objectIDArray) {
                    NSPredicate *predicate4 = [NSPredicate predicateWithFormat:@"course.objectId == %@", courseId];
                    [[TPDBManager sharedInstance] removeLocalObjectsNotOnParseForDBClass:@"TPTutorEntry" parseObjectIDs:objectIDArray predicate:predicate4];
                }
                if (callback) {
                    callback(nil);
                }
            }];
        }
    }];
    
    return YES;
}

@end
