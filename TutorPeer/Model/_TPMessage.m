// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPMessage.m instead.

#import "_TPMessage.h"

const struct TPMessageAttributes TPMessageAttributes = {
	.message = @"message",
};

@implementation TPMessageID
@end

@implementation _TPMessage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TPMessage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TPMessage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TPMessage" inManagedObjectContext:moc_];
}

- (TPMessageID*)objectID {
	return (TPMessageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic message;

@end

