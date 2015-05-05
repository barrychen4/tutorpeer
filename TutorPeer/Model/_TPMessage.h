// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPMessage.h instead.

#import <CoreData/CoreData.h>
#import "TPSyncEntity.h"

extern const struct TPMessageAttributes {
	__unsafe_unretained NSString *message;
} TPMessageAttributes;

@interface TPMessageID : TPSyncEntityID {}
@end

@interface _TPMessage : TPSyncEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPMessageID* objectID;

@property (nonatomic, strong) NSString* message;

//- (BOOL)validateMessage:(id*)value_ error:(NSError**)error_;

@end

@interface _TPMessage (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveMessage;
- (void)setPrimitiveMessage:(NSString*)value;

@end
