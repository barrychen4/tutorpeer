// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPSyncEntity.m instead.

#import "_TPSyncEntity.h"

const struct TPSyncEntityAttributes TPSyncEntityAttributes = {
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

	return keyPaths;
}

@dynamic objectId;

@dynamic updatedAt;

@end

