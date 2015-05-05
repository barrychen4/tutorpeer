// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPMessage.h instead.

#import <CoreData/CoreData.h>

extern const struct TPMessageAttributes {
	__unsafe_unretained NSString *message;
} TPMessageAttributes;

@interface TPMessageID : NSManagedObjectID {}
@end

@interface _TPMessage : NSManagedObject {}
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
