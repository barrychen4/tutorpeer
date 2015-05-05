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
	.tuteeCourses = @"tuteeCourses",
	.tutorCourses = @"tutorCourses",
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

@dynamic tuteeCourses;

- (NSMutableSet*)tuteeCoursesSet {
	[self willAccessValueForKey:@"tuteeCourses"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tuteeCourses"];

	[self didAccessValueForKey:@"tuteeCourses"];
	return result;
}

@dynamic tutorCourses;

- (NSMutableSet*)tutorCoursesSet {
	[self willAccessValueForKey:@"tutorCourses"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tutorCourses"];

	[self didAccessValueForKey:@"tutorCourses"];
	return result;
}

@end

