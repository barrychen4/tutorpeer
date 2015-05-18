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

- (id)init
{
    if (self = [super init]) {
        [self setupObjectManager];
    }
    
    return self;
}

+ (instancetype)sharedInstance
{
    static TPNetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TPNetworkManager alloc] init];
    });
    
    return sharedInstance;
}

+ (NSString *)storePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (void)setupObjectManager
{
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

- (TPSyncEntity *)getLocalObjectForClass:(NSEntityDescription *)entityDesc withRemoteId:(NSString *)objectId
{
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
        NSLog(@"Empty set returned from fetching");
        return nil;
    }
}

- (NSArray *)getLocalObjectsForClass:(NSEntityDescription *)entityDesc withRemoteIds:(NSArray *)objectIds
{
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

- (TPSyncEntity *)addLocalObjectForClass:(NSEntityDescription *)entityDesc withRemoteObject:(PFObject *)parseObject
{
    TPSyncEntity *localObject = [self getLocalObjectForClass:entityDesc withRemoteId:parseObject.objectId];
    if (localObject) {
        NSLog(@"Loaded local object");
        [self updateLocalObject:localObject withRemoteObject:parseObject];
        return localObject;
    }
    
    TPSyncEntity *newObject = [NSEntityDescription insertNewObjectForEntityForName:[entityDesc name] inManagedObjectContext:self.managedObjectContext];
    
    newObject.objectId = parseObject.objectId;
    
    return newObject;
}

- (NSDictionary *)addLocalObjectsForClass:(NSEntityDescription *)entityDesc withRemoteObjects:(NSArray *)parseObjects
{
    NSMutableDictionary *localObjects = [[NSMutableDictionary alloc] init];
    for (PFObject *parseObject in parseObjects) {
        [localObjects setObject:[self addLocalObjectForClass:entityDesc withRemoteObject:parseObject] forKey:parseObject.objectId];
    }
    
    return localObjects;
}

- (void)updateLocalObject:(TPSyncEntity *)localObject withRemoteObject:(PFObject *)parseObject
{
    NSDictionary *attributes = [[localObject entity] attributesByName];
    
    // Update attributes
    for (NSString *attribute in attributes) {
        if (![attribute isEqualToString:@"objectId"] && ![attribute isEqualToString:@"createdAt"] && ![attribute isEqualToString:@"updatedAt"] &&
            ![attribute isEqualToString:@"deleted"]) {
            
            [localObject setValue:[parseObject valueForKey:attribute] forKey:attribute];
        }
    }
    
}




@end
