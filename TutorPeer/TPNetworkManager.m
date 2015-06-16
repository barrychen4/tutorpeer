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

@implementation TPNetworkManager

+ (instancetype)sharedInstance {
    static TPNetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TPNetworkManager alloc] init];
    });
    return sharedInstance;
}

- (BOOL)allParseObjectIDsForPFClass:(NSString *)pfClassName withCallback:(void (^)(NSArray *, NSError *))callback {
    return [self allParseObjectIDsForPFClass:pfClassName predicate:nil withCallback:callback];
}

- (BOOL)allParseObjectIDsForPFClass:(NSString *)pfClassName predicate:(NSPredicate *)predicate withCallback:(void (^)(NSArray *, NSError *))callback {
    
    NSMutableArray *objectIDArray = [NSMutableArray new];
    PFQuery *query;
    if (predicate) {
        query = [PFQuery queryWithClassName:pfClassName predicate:predicate];
    } else {
        query = [PFQuery queryWithClassName:pfClassName];
    }
    query.limit = 1000;
    [query selectKeys:@[]];
    
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

}

@end
