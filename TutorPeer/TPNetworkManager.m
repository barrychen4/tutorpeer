//
//  TPNetworkManager+TPCourseRequests.m
//  TutorPeer
//
//  Created by Yondon Fu on 5/10/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager.h"
#import "TPDBManager.h"
#import <Parse/Parse.h>
#import "TPCourse.h"
#import "TPUser.h"
#import "TPTutorEntry.h"

@interface TPNetworkManager()

@property (strong, nonatomic) TPDBManager *dbManager;

@end

@implementation TPNetworkManager

+ (instancetype)sharedInstance {
    static TPNetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TPNetworkManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.dbManager = [TPDBManager sharedInstance];
    }
    return self;
}

- (void)getCoursesWithCallback:(void (^)(NSArray *))callback delta:(BOOL)delta {
    PFQuery *query;
    query.limit = 1000;
    if (delta) {
        NSDate *latestDate = [self.dbManager latestDateForDBClass:@"TPCourse"];
        if (latestDate) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(updatedAt > %@)", latestDate];
            query = [PFQuery queryWithClassName:@"Course" predicate:predicate];
        } else {
            query = [PFQuery queryWithClassName:@"Course"];
        }
    } else {
        query = [PFQuery queryWithClassName:@"Course"];
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count]) {
            NSArray *localObjects = [self.dbManager addLocalObjectsForDBClass:@"TPCourse" withRemoteObjects:objects];
            callback(localObjects);
        } else if (error) {
            NSLog(@"Error getting Parse courses: %@", error);
        }
    }];
    if (delta) {
        [self allParseObjectIDsForPFClass:@"Course" withCallback:^(NSArray *objectIDArray) {
            [self.dbManager removeLocalObjectsNotOnParseForDBClass:@"TPCourse" parseObjectIDs:objectIDArray];
        }];
    }
}

- (void)getTutorEntriesForCourseId:(NSString *)courseId withCallback:(void (^)(NSArray *))callback delta:(BOOL)delta {
    PFQuery *query;
    if (delta) {
        NSDate *latestDate = [self.dbManager latestDateForDBClass:@"TPCourse"];
        NSPredicate *predicate;
        if (latestDate) {
            predicate = [NSPredicate predicateWithFormat:@"(course == %@) AND (updatedAt > %@)", courseId, latestDate];
        } else {
            predicate = [NSPredicate predicateWithFormat:@"course == %@", courseId];
        }
        query = [PFQuery queryWithClassName:@"TutorEntry" predicate:predicate];
    } else {
        query = [PFQuery queryWithClassName:@"TutorEntry"];
        [query whereKey:@"course" equalTo:courseId];
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count]) {
            NSArray *localObjects = [self.dbManager addLocalObjectsForDBClass:@"TPTutorEntry" withRemoteObjects:objects];
            callback(localObjects);
        } else if (error) {
            NSLog(@"Error getting Parse tutor entries: %@", error);
        }
    }];
    if (delta) {
        [self allParseObjectIDsForPFClass:@"TutorEntry" withCallback:^(NSArray *objectIDArray) {
            [self.dbManager removeLocalObjectsNotOnParseForDBClass:@"TPTutorEntry" parseObjectIDs:objectIDArray];
        }];
    }
}

- (void)allParseObjectIDsForPFClass:(NSString *)pfClassName withCallback:(void (^)(NSArray *))callback {
    NSMutableArray *objectIDArray = [NSMutableArray new];
    PFQuery *query = [[PFQuery alloc] initWithClassName:pfClassName];
    query.limit = 1000;
    [query selectKeys:@[]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && [objects count]) {
            for (PFObject *object in objects) {
                [objectIDArray addObject:object.objectId];
            }
            callback(objectIDArray);
        } else {
            NSLog(@"Error getting Parse IDs: %@", error);
        }
    }];
}

@end
