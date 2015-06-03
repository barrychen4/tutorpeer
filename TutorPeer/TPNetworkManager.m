//
//  TPNetworkManager.m
//  TutorPeer
//
//  Created by Yondon Fu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager.h"
#import "TPSyncEntity.h"
#import "TPCourse.h"
#import <Parse/Parse.h>

@implementation TPNetworkManager

- (id)init {
    if (self = [super init]) {
        [self setupObjectManager];
    }
    
    return self;
}

+ (instancetype)sharedInstance {
    static TPNetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TPNetworkManager alloc] init];
    });
    
    return sharedInstance;
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

- (TPSyncEntity *)getLocalObjectForClass:(NSEntityDescription *)entityDesc withRemoteId:(NSString *)objectId {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entityDesc;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"objectId == %@", objectId];
    [request setPredicate:pred];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    if (result.count > 0) {
        return [result objectAtIndex:0];
    } else {
        NSLog(@"No local object for %@", objectId);
        return nil;
    }
}

- (NSArray *)getLocalObjectsForClass:(NSEntityDescription *)entityDesc withRemoteIds:(NSArray *)objectIds {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entityDesc;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"objectId IN %@", objectIds];
    [request setPredicate:pred];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    return result;
}

- (TPSyncEntity *)addBlankLocalObjectForClass:(NSEntityDescription *)entityDesc withRemoteId:(NSString *)objectId  {
    TPSyncEntity *localObject = [self getLocalObjectForClass:entityDesc withRemoteId:objectId];
    if (localObject) {
        NSLog(@"Loaded local object %@ instead of adding blank", objectId);
    }
    else {
        localObject = [NSEntityDescription insertNewObjectForEntityForName:[entityDesc name] inManagedObjectContext:self.managedObjectContext];
        localObject.objectId = objectId;
    }
    return localObject;
}

- (TPSyncEntity *)addLocalObjectForClass:(NSEntityDescription *)entityDesc withRemoteObject:(PFObject *)parseObject {
    TPSyncEntity *localObject = [self getLocalObjectForClass:entityDesc withRemoteId:parseObject.objectId];
    if (localObject) {
        NSLog(@"Loaded local object %@ instead of adding", parseObject.objectId);
    }
    else {
        localObject = [NSEntityDescription insertNewObjectForEntityForName:[entityDesc name] inManagedObjectContext:self.managedObjectContext];
        localObject.objectId = parseObject.objectId;
    }
    [self updateLocalObjectAttributes:localObject withRemoteObject:parseObject];
    [self updateLocalObjectRelationships:localObject withRemoteObject:parseObject];
    return localObject;
}

- (NSArray *)addLocalObjectsForClass:(NSEntityDescription *)entityDesc withRemoteObjects:(NSArray *)parseObjects {
    NSMutableArray *localObjects = [[NSMutableArray alloc] init];
    for (PFObject *parseObject in parseObjects) {
        [localObjects addObject:[self addLocalObjectForClass:entityDesc withRemoteObject:parseObject]];
    }
    
    return localObjects;
}

- (void)updateLocalObjectAttributes:(TPSyncEntity *)localObject withRemoteObject:(PFObject *)parseObject {
    NSDictionary *attributes = [[localObject entity] attributesByName];
    
    for (NSString *attribute in attributes) {
        if (![attribute isEqualToString:@"objectId"]) {
            [localObject setValue:[parseObject valueForKey:attribute] forKey:attribute];
        }
    }
}

- (void)updateLocalObjectRelationships:(TPSyncEntity *)localObject withRemoteObject:(PFObject *)parseObject {
    NSDictionary *relationships = [[localObject entity] relationshipsByName];
    
    for (NSString *relationship in relationships) {
        NSEntityDescription *entity = ((NSRelationshipDescription *)relationships[relationship]).destinationEntity;

        if ([parseObject[relationship] isKindOfClass:[NSArray class]]) {
            NSMutableSet *relationSet = [localObject mutableSetValueForKey:relationship];
            [relationSet removeAllObjects];
            for (NSString *relatedId in parseObject[relationship]) {
                TPSyncEntity *relatedObject = [self addBlankLocalObjectForClass:entity withRemoteId:relatedId];
                [relationSet addObject:relatedObject];
            }
        } else if ([parseObject[relationship] isKindOfClass:[NSString class]]) {
            NSString *relatedId = parseObject[relationship];
            TPSyncEntity *relatedObject = [self addBlankLocalObjectForClass:entity withRemoteId:relatedId];
            [localObject setValue:relatedObject forKey:relationship];
        }
    }
}

- (NSDate *)latestDateForClass:(NSEntityDescription *)entityDesc {
    NSDate *date;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entityDesc;
    NSSortDescriptor *updatedAtSort = [NSSortDescriptor sortDescriptorWithKey:@"updatedAt" ascending:NO];
    request.sortDescriptors = @[updatedAtSort];
    [request setFetchLimit:1];
    NSError *error;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error) {
        date = ((TPSyncEntity *)objects[0]).updatedAt;
    }
    return date;
}

- (NSArray *)allObjectIDsForClass:(NSEntityDescription *)entityDesc {
    NSMutableArray *objectIDArray = [NSMutableArray new];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entityDesc;
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

@end
