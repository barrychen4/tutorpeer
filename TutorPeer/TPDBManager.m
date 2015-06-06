//
//  TPNetworkManager.m
//  TutorPeer
//
//  Created by Yondon Fu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPDBManager.h"
#import "TPSyncEntity.h"
#import "TPUser.h"
#import <Parse/Parse.h>

@implementation TPDBManager

+ (instancetype)sharedInstance {
    static TPDBManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TPDBManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupObjectManager];
    }
    return self;
}

+ (NSString *)storePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (void)setupObjectManager {
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    NSString *path = [self.class storePath];
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        @throw [NSException exceptionWithName:@"OpenFailure" reason:[error localizedDescription] userInfo:nil];
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    _managedObjectContext.persistentStoreCoordinator = psc;
}

- (TPSyncEntity *)getLocalObjectForDBClass:(NSString *)dbClassName withRemoteId:(NSString *)objectId {
    TPSyncEntity *localObject;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:dbClassName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId == %@", objectId];
    request.predicate = predicate;
    request.fetchLimit = 1;
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Fetch failed %@", error);
    }
    if ([result count]) {
        localObject = result[0];
    }
    return localObject;
}

- (NSArray *)getLocalObjectsForDBClass:(NSString *)dbClassName withRemoteIds:(NSArray *)objectIds {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:dbClassName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId IN %@", objectIds];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Fetch batch failed %@", error);
    }
    return result;
}

- (TPSyncEntity *)addBlankLocalObjectForDBClass:(NSString *)dbClassName withRemoteId:(NSString *)objectId  {
    TPSyncEntity *localObject = [self getLocalObjectForDBClass:dbClassName withRemoteId:objectId];
    if (!localObject) {
        localObject = [NSEntityDescription insertNewObjectForEntityForName:dbClassName inManagedObjectContext:self.managedObjectContext];
        localObject.objectId = objectId;
    }
    return localObject;
}

- (TPSyncEntity *)addLocalObjectForDBClass:(NSString *)dbClassName withRemoteObject:(PFObject *)parseObject {
    TPSyncEntity *localObject = [self getLocalObjectForDBClass:dbClassName withRemoteId:parseObject.objectId];
    if (!localObject) {
        localObject = [NSEntityDescription insertNewObjectForEntityForName:dbClassName inManagedObjectContext:self.managedObjectContext];
        localObject.objectId = parseObject.objectId;
    }
    [self updateLocalObjectAttributes:localObject withRemoteObject:parseObject];
    [self updateLocalObjectRelationships:localObject withRemoteObject:parseObject];
    return localObject;
}

- (NSArray *)addLocalObjectsForDBClass:(NSString *)dbClassName withRemoteObjects:(NSArray *)parseObjects {
    NSMutableArray *localObjects = [[NSMutableArray alloc] init];
    for (PFObject *parseObject in parseObjects) {
        [localObjects addObject:[self addLocalObjectForDBClass:dbClassName withRemoteObject:parseObject]];
    }
    NSError *error;
    [self.managedObjectContext save:&error];
    if (error) {
        NSLog(@"Error adding objects locally: %@", error);
    }
    return localObjects;
}

- (void)updateLocalObjectAttributes:(TPSyncEntity *)localObject withRemoteObject:(PFObject *)parseObject {
    NSDictionary *attributes = [[localObject entity] attributesByName];
    for (NSString *attribute in attributes) {
        if (![attribute isEqualToString:@"objectId"] && ![attribute isEqualToString:@"loggedIn"] && ![attribute isEqualToString:@"picture"]) {
            [localObject setValue:[parseObject valueForKey:attribute] forKey:attribute];
        }
    }
}

- (void)updateLocalObjectRelationships:(TPSyncEntity *)localObject withRemoteObject:(PFObject *)parseObject {
    NSDictionary *relationships = [[localObject entity] relationshipsByName];
    for (NSString *relationship in relationships) {
        NSString *className = ((NSRelationshipDescription *)relationships[relationship]).destinationEntity.name;
        if ([parseObject[relationship] isKindOfClass:[NSArray class]]) {
            NSMutableSet *relatedSet = [localObject mutableSetValueForKey:relationship];

            [relatedSet removeAllObjects];
            for (NSString *relatedId in parseObject[relationship]) {
                TPSyncEntity *relatedObject = [self addBlankLocalObjectForDBClass:className withRemoteId:relatedId];
                [relatedSet addObject:relatedObject];
            }
        } else if ([parseObject[relationship] isKindOfClass:[NSString class]]) {
            NSString *relatedId = parseObject[relationship];
            TPSyncEntity *relatedObject = [self addBlankLocalObjectForDBClass:className withRemoteId:relatedId];
            [localObject setValue:relatedObject forKey:relationship];
        }
    }
}

- (NSDate *)latestDateForDBClass:(NSString *)dbClassName {
    return [self latestDateForDBClass:dbClassName predicate:nil];
}

- (NSDate *)latestDateForDBClass:(NSString *)dbClassName predicate:(NSPredicate *)predicate {
    NSDate *date;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:dbClassName];
    request.predicate = predicate;
    NSSortDescriptor *updatedAtSort = [NSSortDescriptor sortDescriptorWithKey:@"updatedAt" ascending:NO];
    request.sortDescriptors = @[updatedAtSort];
    [request setFetchLimit:1];
    NSError *error;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:&error];
    if ([objects count]) {
        date = ((TPSyncEntity *)objects[0]).updatedAt;
    }
    return date;
}

- (NSArray *)allLocalObjectIDsForDBClass:(NSString *)dbClassName {
    return [self allLocalObjectIDsForDBClass:dbClassName predicate:nil];
}

- (NSArray *)allLocalObjectIDsForDBClass:(NSString *)dbClassName predicate:(NSPredicate *)predicate {
    NSMutableArray *objectIDArray = [NSMutableArray new];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:dbClassName];
    request.predicate = predicate;
    request.resultType = NSDictionaryResultType;
    request.returnsDistinctResults = YES;
    request.propertiesToFetch = @[@"objectId"];
    
    NSError *error;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:&error];
    for (NSDictionary *dict in objects) {
        [objectIDArray addObject:dict[@"objectId"]];
    }
    return objectIDArray;
}

- (void)removeLocalObjectsNotOnParseForDBClass:(NSString *)dbClassName parseObjectIDs:(NSArray *)parseObjectIDs {
    [self removeLocalObjectsNotOnParseForDBClass:dbClassName parseObjectIDs:parseObjectIDs predicate:nil];
}

- (void)removeLocalObjectsNotOnParseForDBClass:(NSString *)dbClassName parseObjectIDs:(NSArray *)parseObjectIDs predicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:dbClassName];
    if (predicate) {
        NSPredicate *mainPredicate = [NSPredicate predicateWithFormat:@"NOT (objectId IN %@)", parseObjectIDs];
        NSCompoundPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate, mainPredicate]];
        request.predicate = compoundPredicate;
    } else {
        request.predicate = [NSPredicate predicateWithFormat:@"NOT (objectId IN %@)", parseObjectIDs];
    }
    
    NSError *error;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:&error];
    for (TPSyncEntity *object in objects) {
        [self.managedObjectContext deleteObject:object];
    }
    NSLog(@"Deleted %lu objects", [objects count]);
    [self.managedObjectContext save:&error];
    if (error) {
        NSLog(@"Error deleting objects locally: %@", error);
    }
}

- (TPUser *)currentUser {
    if (!_currentUser) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loggedIn == YES"];
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"TPUser"];
        request.predicate = predicate;
        request.fetchLimit = 1;
        NSError *error;
        NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:&error];
        if ([objects count]) {
            _currentUser = objects[0];
        }
    }
    return _currentUser;
}

- (TPUser *)makeCurrentUserWithId:(NSString *)objectId {
    TPUser *currentUser;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId == %@", [PFUser currentUser].objectId];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"TPUser"];
    request.predicate = predicate;
    request.fetchLimit = 1;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:nil];
    if ([objects count]) {
        currentUser = objects[0];
    } else {
        currentUser = (TPUser *)[self addBlankLocalObjectForDBClass:@"TPUser" withRemoteId:[PFUser currentUser].objectId];
    }
    currentUser.loggedIn = [NSNumber numberWithBool:YES];
    _currentUser = currentUser;
    return currentUser;
}

- (void)updateLocalUser {
    TPUser *currentUser;
    TPUser *user = [self currentUser];
    if (user) {
        if ([user.objectId isEqual:[PFUser currentUser].objectId]) {
            currentUser = user;
        } else {
            user.loggedIn = [NSNumber numberWithBool:NO];
            currentUser = [self makeCurrentUserWithId:[PFUser currentUser].objectId];
        }
    } else {
        currentUser = [self makeCurrentUserWithId:[PFUser currentUser].objectId];
    }
    
    [self updateLocalObjectAttributes:currentUser withRemoteObject:[PFUser currentUser]];
    [self updateLocalObjectRelationships:currentUser withRemoteObject:[PFUser currentUser]];
    NSError *error;
    [self.managedObjectContext save:&error];
    if (error) {
        NSLog(@"Error saving user locally: %@", error);
    }
}

@end
