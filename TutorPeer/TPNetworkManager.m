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
        _dbManager = [TPDBManager sharedInstance];
    }
    return self;
}

- (BOOL)refreshCoursesWithCallback:(void (^)(NSError *))callback async:(BOOL)async {
    PFQuery *query;
    query.limit = 1000;
    
    NSDate *latestDate = [self.dbManager latestDateForDBClass:@"TPCourse"];
    if (latestDate) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(updatedAt > %@)", latestDate];
        query = [PFQuery queryWithClassName:@"Course" predicate:predicate];
    } else {
        query = [PFQuery queryWithClassName:@"Course"];
    }
    if (async) {
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"Error getting Parse courses: %@", error);
                if (callback) {
                    callback(error);
                }
            } else {
                if ([objects count]) {
                    [self.dbManager addLocalObjectsForDBClass:@"TPCourse" withRemoteObjects:objects];
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
                            [self.dbManager removeLocalObjectsNotOnParseForDBClass:@"TPCourse" parseObjectIDs:objectIDArray];
                        }
                        if (callback) {
                            callback(nil);
                        }
                    }
                } async:YES];
            }
        }];
        return YES;
    } else {
        NSError *error;
        NSArray *objects = [query findObjects:&error];
        if (error) {
            NSLog(@"Error getting Parse courses: %@", error);
            if (callback) {
                callback(error);
            }
            return NO;
        } else {
            if ([objects count]) {
                [self.dbManager addLocalObjectsForDBClass:@"TPCourse" withRemoteObjects:objects];
                NSLog(@"Got %lu new courses", [objects count]);
            }
            return [self allParseObjectIDsForPFClass:@"Course" withCallback:^(NSArray *objectIDArray, NSError *error) {
                if (objectIDArray) {
                    [self.dbManager removeLocalObjectsNotOnParseForDBClass:@"TPCourse" parseObjectIDs:objectIDArray];
                }
                if (callback) {
                    callback(nil);
                }
            } async:NO];
        }
    }
}

- (BOOL)refreshTutorEntriesForCourseId:(NSString *)courseId withCallback:(void (^)(NSError *))callback async:(BOOL)async {
    PFQuery *query;
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"course.objectId == %@", courseId];
    NSDate *latestDate = [self.dbManager latestDateForDBClass:@"TPTutorEntry" predicate:predicate1];
    NSPredicate *predicate2;
    if (latestDate) {
        predicate2 = [NSPredicate predicateWithFormat:@"(course == %@) AND (updatedAt > %@)", courseId, latestDate];
    } else {
        predicate2 = [NSPredicate predicateWithFormat:@"course == %@", courseId];
    }
    query = [PFQuery queryWithClassName:@"TutorEntry" predicate:predicate2];
    if (async) {
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"Error getting Parse tutor entries: %@", error);
                if (callback) {
                    callback(error);
                }
            } else {
                if ([objects count]) {
                    [self.dbManager addLocalObjectsForDBClass:@"TPTutorEntry" withRemoteObjects:objects];
                    NSLog(@"Got %lu new tutor entries", [objects count]);
                }
                NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"course == %@", courseId];
                [self allParseObjectIDsForPFClass:@"TutorEntry" predicate:predicate3 withCallback:^(NSArray *objectIDArray, NSError *error) {
                    if (objectIDArray) {
                        NSPredicate *predicate4 = [NSPredicate predicateWithFormat:@"course.objectId == %@", courseId];
                        [self.dbManager removeLocalObjectsNotOnParseForDBClass:@"TPTutorEntry" parseObjectIDs:objectIDArray predicate:predicate4];
                    }
                    if (callback) {
                        callback(nil);
                    }
                } async:YES];
            }
        }];
        return YES;
    } else {
        NSError *error;
        NSArray *objects = [query findObjects:&error];
        if (error) {
            NSLog(@"Error getting Parse tutor entries: %@", error);
            if (callback) {
                callback(error);
            }
            return NO;
        } else {
            if ([objects count]) {
                [self.dbManager addLocalObjectsForDBClass:@"TPTutorEntry" withRemoteObjects:objects];
                NSLog(@"Got %lu new tutor entries", [objects count]);
            }
            NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"course == %@", courseId];
            return [self allParseObjectIDsForPFClass:@"TutorEntry" predicate:predicate3 withCallback:^(NSArray *objectIDArray, NSError *error) {
                if (objectIDArray) {
                    NSPredicate *predicate4 = [NSPredicate predicateWithFormat:@"course.objectId == %@", courseId];
                    [self.dbManager removeLocalObjectsNotOnParseForDBClass:@"TPTutorEntry" parseObjectIDs:objectIDArray predicate:predicate4];
                }
                if (callback) {
                    callback(nil);
                }
            } async:NO];
        }
    }
}

- (BOOL)refreshContractsForUserId:(NSString *)userId withCallback:(void (^)(NSError *))callback async:(BOOL)async {
    PFQuery *query;
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(tutor.objectId == %@) OR (tutee.objectId == %@)", userId, userId];
    NSDate *latestDate = [self.dbManager latestDateForDBClass:@"TPContract" predicate:predicate1];
    NSPredicate *predicate2;
    if (latestDate) {
        predicate2 = [NSPredicate predicateWithFormat:@"((tutor == %@) OR (tutee == %@)) AND (updatedAt > %@)", userId, userId, latestDate];
    } else {
        predicate2 = [NSPredicate predicateWithFormat:@"(tutor == %@) OR (tutee == %@)", userId, userId];
    }
    query = [PFQuery queryWithClassName:@"Contract" predicate:predicate2];
    if (async) {
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"Error getting Parse contracts: %@", error);
                if (callback) {
                    callback(error);
                }
            } else {
                BOOL gotNewObjects = NO;
                if ([objects count]) {
                    [self.dbManager addLocalObjectsForDBClass:@"TPContract" withRemoteObjects:objects];
                    NSLog(@"Got %lu contracts", [objects count]);
                    gotNewObjects = YES;
                }
                NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"(tutor == %@) OR (tutee == %@)", userId, userId];
                [self allParseObjectIDsForPFClass:@"Contract" predicate:predicate3 withCallback:^(NSArray *objectIDArray, NSError *error) {
                    if (objectIDArray) {
                        NSPredicate *predicate4 = [NSPredicate predicateWithFormat:@"(tutor.objectId == %@) OR (tutee.objectId == %@)", userId, userId];
                        [self.dbManager removeLocalObjectsNotOnParseForDBClass:@"TPContract" parseObjectIDs:objectIDArray predicate:predicate4];
                    }
                    if (callback) {
                        callback(nil);
                    }
                } async:YES];
            }
        }];
        return YES;
    } else {
        NSError *error;
        NSArray *objects = [query findObjects:&error];
        if (error) {
            NSLog(@"Error getting Parse contracts: %@", error);
            if (callback) {
                callback(error);
            }
            return NO;
        } else {
            if ([objects count]) {
                [self.dbManager addLocalObjectsForDBClass:@"TPContract" withRemoteObjects:objects];
                NSLog(@"Got %lu new contracts", [objects count]);
            }
            NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"(tutor == %@) OR (tutee == %@)", userId, userId];
            return [self allParseObjectIDsForPFClass:@"Contract" predicate:predicate3 withCallback:^(NSArray *objectIDArray, NSError *error) {
                if (objectIDArray) {
                    NSPredicate *predicate4 = [NSPredicate predicateWithFormat:@"(tutor.objectId == %@) OR (tutee.objectId == %@)", userId, userId];
                    [self.dbManager removeLocalObjectsNotOnParseForDBClass:@"TPContract" parseObjectIDs:objectIDArray predicate:predicate4];
                }
                if (callback) {
                    callback(nil);
                }
            } async:NO];
        }
    }
}

- (BOOL)allParseObjectIDsForPFClass:(NSString *)pfClassName withCallback:(void (^)(NSArray *, NSError *))callback async:(BOOL)async {
    return [self allParseObjectIDsForPFClass:pfClassName predicate:nil withCallback:callback async:async];
}

- (BOOL)allParseObjectIDsForPFClass:(NSString *)pfClassName predicate:(NSPredicate *)predicate withCallback:(void (^)(NSArray *, NSError *))callback async:(BOOL)async {
    NSMutableArray *objectIDArray = [NSMutableArray new];
    PFQuery *query;
    if (predicate) {
        query = [PFQuery queryWithClassName:pfClassName predicate:predicate];
    } else {
        query = [PFQuery queryWithClassName:pfClassName];
    }
    query.limit = 1000;
    [query selectKeys:@[]];
    if (async) {
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"Error getting Parse IDs: %@", error);
                if (callback) {
                    callback(nil, error);
                }
            } else {
                if ([objects count]) {
                    for (PFObject *object in objects) {
                        [objectIDArray addObject:object.objectId];
                    }
                }
                if (callback) {
                    callback(objectIDArray, nil);
                }
            }
        }];
        return YES;
    } else {
        NSError *error;
        NSArray *objects = [query findObjects:&error];
        if (error) {
            NSLog(@"Error getting Parse IDs: %@", error);
            if (callback) {
                callback(nil, error);
            }
            return NO;
        } else {
            if ([objects count]) {
                for (PFObject *object in objects) {
                    [objectIDArray addObject:object.objectId];
                }
            }
            if (callback) {
                callback(objectIDArray, nil);
            }
            return YES;
        }
    }
}
                    
@end
