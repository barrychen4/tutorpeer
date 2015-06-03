// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPConversation.m instead.

#import "_TPConversation.h"

const struct TPConversationRelationships TPConversationRelationships = {
	.contract = @"contract",
	.messages = @"messages",
	.participants = @"participants",
};

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

@dynamic contract;

@dynamic messages;

- (NSMutableSet*)messagesSet {
	[self willAccessValueForKey:@"messages"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"messages"];

	[self didAccessValueForKey:@"messages"];
	return result;
}

@dynamic participants;

- (NSMutableSet*)participantsSet {
	[self willAccessValueForKey:@"participants"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"participants"];

	[self didAccessValueForKey:@"participants"];
	return result;
}

@end

