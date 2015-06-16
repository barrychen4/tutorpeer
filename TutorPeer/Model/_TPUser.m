// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPUser.m instead.

#import "_TPUser.h"

const struct TPUserAttributes TPUserAttributes = {
	.defaultBio = @"defaultBio",
	.defaultPrice = @"defaultPrice",
	.email = @"email",
	.firstName = @"firstName",
	.lastName = @"lastName",
	.loggedIn = @"loggedIn",
	.profileImage = @"profileImage",
};

const struct TPUserRelationships TPUserRelationships = {
	.contracts = @"contracts",
	.conversations = @"conversations",
	.tutorEntries = @"tutorEntries",
};

@implementation TPUserID
@end

@implementation _TPUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TPUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TPUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TPUser" inManagedObjectContext:moc_];
}

- (TPUserID*)objectID {
	return (TPUserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"defaultPriceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"defaultPrice"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"loggedInValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"loggedIn"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic defaultBio;

@dynamic defaultPrice;

- (double)defaultPriceValue {
	NSNumber *result = [self defaultPrice];
	return [result doubleValue];
}

- (void)setDefaultPriceValue:(double)value_ {
	[self setDefaultPrice:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveDefaultPriceValue {
	NSNumber *result = [self primitiveDefaultPrice];
	return [result doubleValue];
}

- (void)setPrimitiveDefaultPriceValue:(double)value_ {
	[self setPrimitiveDefaultPrice:[NSNumber numberWithDouble:value_]];
}

@dynamic email;

@dynamic firstName;

@dynamic lastName;

@dynamic loggedIn;

- (BOOL)loggedInValue {
	NSNumber *result = [self loggedIn];
	return [result boolValue];
}

- (void)setLoggedInValue:(BOOL)value_ {
	[self setLoggedIn:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveLoggedInValue {
	NSNumber *result = [self primitiveLoggedIn];
	return [result boolValue];
}

- (void)setPrimitiveLoggedInValue:(BOOL)value_ {
	[self setPrimitiveLoggedIn:[NSNumber numberWithBool:value_]];
}

@dynamic profileImage;

@dynamic contracts;

- (NSMutableSet*)contractsSet {
	[self willAccessValueForKey:@"contracts"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"contracts"];

	[self didAccessValueForKey:@"contracts"];
	return result;
}

@dynamic conversations;

- (NSMutableSet*)conversationsSet {
	[self willAccessValueForKey:@"conversations"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"conversations"];

	[self didAccessValueForKey:@"conversations"];
	return result;
}

@dynamic tutorEntries;

- (NSMutableSet*)tutorEntriesSet {
	[self willAccessValueForKey:@"tutorEntries"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tutorEntries"];

	[self didAccessValueForKey:@"tutorEntries"];
	return result;
}

@end

