// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPCourse.m instead.

#import "_TPCourse.h"

const struct TPCourseAttributes TPCourseAttributes = {
	.courseCode = @"courseCode",
	.courseName = @"courseName",
};

const struct TPCourseRelationships TPCourseRelationships = {
	.tutees = @"tutees",
	.tutors = @"tutors",
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

@dynamic tutees;

- (NSMutableSet*)tuteesSet {
	[self willAccessValueForKey:@"tutees"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tutees"];

	[self didAccessValueForKey:@"tutees"];
	return result;
}

@dynamic tutors;

- (NSMutableSet*)tutorsSet {
	[self willAccessValueForKey:@"tutors"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tutors"];

	[self didAccessValueForKey:@"tutors"];
	return result;
}

@end

