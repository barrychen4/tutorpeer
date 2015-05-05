// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPSyncEntity.m instead.

#import "_TPSyncEntity.h"

const struct TPSyncEntityAttributes TPSyncEntityAttributes = {
	.createdAt = @"createdAt",
	.deleted = @"deleted",
	.objectId = @"objectId",
	.updatedAt = @"updatedAt",
};

@implementation TPSyncEntityID
@end

@implementation _TPSyncEntity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TPSyncEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TPSyncEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TPSyncEntity" inManagedObjectContext:moc_];
}

- (TPSyncEntityID*)objectID {
	return (TPSyncEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"deletedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"deleted"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic createdAt;

@dynamic deleted;

- (BOOL)deletedValue {
	NSNumber *result = [self deleted];
	return [result boolValue];
}

- (void)setDeletedValue:(BOOL)value_ {
	[self setDeleted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveDeletedValue {
	NSNumber *result = [self primitiveDeleted];
	return [result boolValue];
}

- (void)setPrimitiveDeletedValue:(BOOL)value_ {
	[self setPrimitiveDeleted:[NSNumber numberWithBool:value_]];
}

@dynamic objectId;

@dynamic updatedAt;

@end

