// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPTutorEntry.m instead.

#import "_TPTutorEntry.h"

const struct TPTutorEntryAttributes TPTutorEntryAttributes = {
	.price = @"price",
};

const struct TPTutorEntryRelationships TPTutorEntryRelationships = {
	.course = @"course",
	.tutor = @"tutor",
};

@implementation TPTutorEntryID
@end

@implementation _TPTutorEntry

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TPTutorEntry" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TPTutorEntry";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TPTutorEntry" inManagedObjectContext:moc_];
}

- (TPTutorEntryID*)objectID {
	return (TPTutorEntryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic price;

- (double)priceValue {
	NSNumber *result = [self price];
	return [result doubleValue];
}

- (void)setPriceValue:(double)value_ {
	[self setPrice:[NSNumber numberWithDouble:value_]];
}

- (double)primitivePriceValue {
	NSNumber *result = [self primitivePrice];
	return [result doubleValue];
}

- (void)setPrimitivePriceValue:(double)value_ {
	[self setPrimitivePrice:[NSNumber numberWithDouble:value_]];
}

@dynamic course;

@dynamic tutor;

@end

