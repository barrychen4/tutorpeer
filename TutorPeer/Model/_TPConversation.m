// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPConversation.m instead.

#import "_TPConversation.h"

@implementation TPConversationID
@end

@implementation _TPConversation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TPConversation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TPConversation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TPConversation" inManagedObjectContext:moc_];
}

- (TPConversationID*)objectID {
	return (TPConversationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@end

