//
//  TPNetworkManager.h
//  TutorPeer
//
//  Created by Yondon Fu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPSyncEntity.h"
#import <Parse/Parse.h>

@import CoreData;

@interface TPNetworkManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

+ (instancetype)sharedInstance;
+ (NSString *)storePath;

- (TPSyncEntity *)getLocalObjectForClass:(NSEntityDescription *)entityDesc withRemoteId:(NSString *)objectId;
- (NSArray *)getLocalObjectsForClass:(NSEntityDescription *)entityDesc withRemoteIds:(NSArray *)objectIds;
- (TPSyncEntity *)addLocalObjectForClass:(NSEntityDescription *)entityDesc withRemoteObject:(PFObject *)parseObject;
- (NSDictionary *)addLocalObjectsForClass:(NSEntityDescription *)entityDesc withRemoteObjects:(NSArray *)parseObjects;

@end
