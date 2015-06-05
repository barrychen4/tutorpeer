//
//  TPNetworkManager.h
//  TutorPeer
//
//  Created by Yondon Fu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;
@class TPSyncEntity, TPUser;

@interface TPDBManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) TPUser *currentUser;

+ (instancetype)sharedInstance;
+ (NSString *)storePath;

- (TPSyncEntity *)getLocalObjectForDBClass:(NSString *)dbClassName withRemoteId:(NSString *)objectId;
- (NSArray *)getLocalObjectsForDBClass:(NSString *)dbClassName withRemoteIds:(NSArray *)objectIds;
- (NSArray *)addLocalObjectsForDBClass:(NSString *)dbClassName withRemoteObjects:(NSArray *)parseObjects;
- (NSDate *)latestDateForDBClass:(NSString *)dbClassName;
- (NSArray *)allLocalObjectIDsForDBClass:(NSString *)dbClassName;
- (NSArray *)allLocalObjectIDsForDBClass:(NSString *)dbClassName predicate:(NSPredicate *)predicate;
- (void)removeLocalObjectsNotOnParseForDBClass:(NSString *)dbClassName parseObjectIDs:(NSArray *)parseObjectIDs;
- (void)updateLocalUser;

@end
