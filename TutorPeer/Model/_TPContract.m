// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPContract.m instead.

#import "_TPContract.h"

const struct TPContractAttributes TPContractAttributes = {
	.hrsWeek = @"hrsWeek",
	.price = @"price",
	.status = @"status",
};

const struct TPContractRelationships TPContractRelationships = {
	.conversation = @"conversation",
	.course = @"course",
	.tutee = @"tutee",
	.tutor = @"tutor",
};

@implementation TPContractID
@end

@implementation _TPContract

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TPContract" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TPContract";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TPContract" inManagedObjectContext:moc_];
}

- (TPContractID*)objectID {
	return (TPContractID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"hrsWeekValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hrsWeek"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"statusValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"status"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic hrsWeek;

- (int32_t)hrsWeekValue {
	NSNumber *result = [self hrsWeek];
	return [result intValue];
}

- (void)setHrsWeekValue:(int32_t)value_ {
	[self setHrsWeek:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveHrsWeekValue {
	NSNumber *result = [self primitiveHrsWeek];
	return [result intValue];
}

- (void)setPrimitiveHrsWeekValue:(int32_t)value_ {
	[self setPrimitiveHrsWeek:[NSNumber numberWithInt:value_]];
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

@dynamic status;

- (int32_t)statusValue {
	NSNumber *result = [self status];
	return [result intValue];
}

- (void)setStatusValue:(int32_t)value_ {
	[self setStatus:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveStatusValue {
	NSNumber *result = [self primitiveStatus];
	return [result intValue];
}

- (void)setPrimitiveStatusValue:(int32_t)value_ {
	[self setPrimitiveStatus:[NSNumber numberWithInt:value_]];
}

@dynamic conversation;

@dynamic course;

@dynamic tutee;

@dynamic tutor;

@end

