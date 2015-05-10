// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPTuteeEntry.m instead.

#import "_TPTuteeEntry.h"

const struct TPTuteeEntryRelationships TPTuteeEntryRelationships = {
	.course = @"course",
	.tutee = @"tutee",
};

@implementation TPTuteeEntryID
@end

@implementation _TPTuteeEntry

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TPTuteeEntry" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TPTuteeEntry";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TPTuteeEntry" inManagedObjectContext:moc_];
}

- (TPTuteeEntryID*)objectID {
	return (TPTuteeEntryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic course;

@dynamic tutee;

@end

