//
//  TPNetworkManager+CourseRequests.m
//  TutorPeer
//
//  Created by Yondon Fu on 6/16/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager+CourseRequests.h"
#import "TPNetworkManager.h"
#import "TPDBManager.h"
#import <Parse/Parse.h>

@implementation TPNetworkManager (CourseRequests)

- (BOOL)refreshCoursesWithCallback:(void (^)(NSError *))callback
{
    PFQuery *query;
    query.limit = 1000;
    
    NSDate *latestDate = [[TPDBManager sharedInstance] latestDateForDBClass:@"TPCourse"];
    if (latestDate) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(updatedAt > %@)", latestDate];
        query = [PFQuery queryWithClassName:@"Course" predicate:predicate];
    } else {
        query = [PFQuery queryWithClassName:@"Course"];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error getting Parse courses: %@", error);
            if (callback) {
                callback(error);
            }
        } else {
            if ([objects count]) {
                [[TPDBManager sharedInstance] addLocalObjectsForDBClass:@"TPCourse" withRemoteObjects:objects];
                NSLog(@"Got %lu new courses", [objects count]);
            }
            [self allParseObjectIDsForPFClass:@"Course" withCallback:^(NSArray *objectIDArray, NSError *error) {
                if (error) {
                    if (callback) {
                        callback(error);
                    }
                }
                else {
                    if (objectIDArray) {
                        [[TPDBManager sharedInstance] removeLocalObjectsNotOnParseForDBClass:@"TPCourse" parseObjectIDs:objectIDArray];
                    }
                    if (callback) {
                        callback(nil);
                    }
                }
            }];
        }
    }];
    
    return YES;
}


@end
