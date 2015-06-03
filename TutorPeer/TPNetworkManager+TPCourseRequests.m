//
//  TPNetworkManager+TPCourseRequests.m
//  TutorPeer
//
//  Created by Yondon Fu on 5/10/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager+TPCourseRequests.h"
#import <Parse/Parse.h>
#import "TPCourse.h"
#import "TPTutorEntry.h"

@implementation TPNetworkManager (TPCourseRequests)

- (void)getCoursesWithCallback:(void (^)(NSArray *))callback delta:(BOOL)delta {
    NSEntityDescription *e = [NSEntityDescription entityForName:@"TPCourse" inManagedObjectContext:self.managedObjectContext];
    NSDate *latestDate = [self latestDateForClass:e];
    PFQuery *query;
    if (delta) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(updatedAt > %@)", latestDate];
        query = [PFQuery queryWithClassName:@"Course" predicate:predicate];
    } else {
        query = [PFQuery queryWithClassName:@"Course"];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSArray *localObjects = [self addLocalObjectsForClass:e withRemoteObjects:objects];
            NSError *error;
            [self.managedObjectContext save:&error];
            if (error) {
                NSLog(@"Error adding courses locally");
            }
            else {
                NSLog(@"Added courses locally");
            }
            callback(localObjects);
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (void)getTutorEntriesForCourse:(NSString *)courseCode withCallback:(void (^)(NSArray *))callback delta:(BOOL)delta {
    NSEntityDescription *e = [NSEntityDescription entityForName:@"TPTutorEntry" inManagedObjectContext:self.managedObjectContext];
    NSDate *latestDate = [self latestDateForClass:e];
    PFQuery *query;
    if (delta) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(updatedAt > %@) AND (course == %@)", latestDate, courseCode];
        query = [PFQuery queryWithClassName:@"TutorEntry" predicate:predicate];
    } else {
        query = [PFQuery queryWithClassName:@"Course"];
        [query whereKey:@"course" equalTo:courseCode];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSArray *localObjects = [self addLocalObjectsForClass:e withRemoteObjects:objects];
            
            [self.managedObjectContext save:&error];
            if (error) {
                NSLog(@"Error adding tutor entries locally");
            }
            else {
                NSLog(@"Added tutor entries locally");
            }
            callback(localObjects);
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


@end
