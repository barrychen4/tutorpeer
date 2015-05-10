//
//  TPNetworkManager.m
//  TutorPeer
//
//  Created by Yondon Fu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager.h"
#import "TPSyncEntity.h"
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
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"objectId IN %@", objectId];
    [request setPredicate:pred];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    if (result.count > 0) {
        return [result objectAtIndex:0];
    } else {
        NSLog(@"Error with fetching, empty set returned from fetching");
        return nil;
    }
}

- (TPSyncEntity *)addLocalObjectForClass:(NSEntityDescription *)entityDesc withRemoteObject:(PFObject *)parseObject
{
    TPSyncEntity *localObject = [self getLocalObjectForClass:entityDesc withRemoteId:parseObject.objectId];
    if (localObject) {
        return localObject;
    }
    
    TPSyncEntity *newObject = [NSEntityDescription insertNewObjectForEntityForName:[entityDesc name] inManagedObjectContext:self.managedObjectContext];
    
    newObject.objectId = parseObject.objectId;
    
    return newObject;
}


@end
