// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPCourse.m instead.

#import "_TPCourse.h"

const struct TPCourseAttributes TPCourseAttributes = {
	.courseCode = @"courseCode",
	.courseName = @"courseName",
};

const struct TPCourseRelationships TPCourseRelationships = {
	.contracts = @"contracts",
	.tuteeEntries = @"tuteeEntries",
	.tutorEntries = @"tutorEntries",
};

@implementation TPCourseID
@end

@implementation _TPCourse

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TPCourse" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TPCourse";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TPCourse" inManagedObjectContext:moc_];
}

- (TPCourseID*)objectID {
	return (TPCourseID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic courseCode;

@dynamic courseName;

@dynamic contracts;

- (NSMutableSet*)contractsSet {
	[self willAccessValueForKey:@"contracts"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"contracts"];

	[self didAccessValueForKey:@"contracts"];
	return result;
}

@dynamic tuteeEntries;

- (NSMutableSet*)tuteeEntriesSet {
	[self willAccessValueForKey:@"tuteeEntries"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tuteeEntries"];

	[self didAccessValueForKey:@"tuteeEntries"];
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

