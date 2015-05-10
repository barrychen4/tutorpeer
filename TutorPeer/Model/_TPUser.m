// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPUser.m instead.

#import "_TPUser.h"

const struct TPUserAttributes TPUserAttributes = {
	.email = @"email",
	.firstName = @"firstName",
	.lastName = @"lastName",
	.profileImage = @"profileImage",
};

const struct TPUserRelationships TPUserRelationships = {
	.tuteeContracts = @"tuteeContracts",
	.tuteeEntries = @"tuteeEntries",
	.tutorContracts = @"tutorContracts",
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

	return keyPaths;
}

@dynamic email;

@dynamic firstName;

@dynamic lastName;

@dynamic profileImage;

@dynamic tuteeContracts;

- (NSMutableSet*)tuteeContractsSet {
	[self willAccessValueForKey:@"tuteeContracts"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tuteeContracts"];

	[self didAccessValueForKey:@"tuteeContracts"];
	return result;
}

@dynamic tuteeEntries;

- (NSMutableSet*)tuteeEntriesSet {
	[self willAccessValueForKey:@"tuteeEntries"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tuteeEntries"];

	[self didAccessValueForKey:@"tuteeEntries"];
	return result;
}

@dynamic tutorContracts;

- (NSMutableSet*)tutorContractsSet {
	[self willAccessValueForKey:@"tutorContracts"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tutorContracts"];

	[self didAccessValueForKey:@"tutorContracts"];
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

