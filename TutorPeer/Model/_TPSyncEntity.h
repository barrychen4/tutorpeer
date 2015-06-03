// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPSyncEntity.h instead.

#import <CoreData/CoreData.h>

extern const struct TPSyncEntityAttributes {
	__unsafe_unretained NSString *objectId;
	__unsafe_unretained NSString *updatedAt;
} TPSyncEntityAttributes;

@interface TPSyncEntityID : NSManagedObjectID {}
@end

@interface _TPSyncEntity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPSyncEntityID* objectID;

@property (nonatomic, strong) NSString* objectId;

//- (BOOL)validateObjectId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* updatedAt;

//- (BOOL)validateUpdatedAt:(id*)value_ error:(NSError**)error_;

@end

@interface _TPSyncEntity (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveObjectId;
- (void)setPrimitiveObjectId:(NSString*)value;

- (NSDate*)primitiveUpdatedAt;
- (void)setPrimitiveUpdatedAt:(NSDate*)value;

@end
