// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPMessage.h instead.

#import <CoreData/CoreData.h>
#import "TPSyncEntity.h"

extern const struct TPMessageAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *from;
	__unsafe_unretained NSString *message;
	__unsafe_unretained NSString *to;
} TPMessageAttributes;

extern const struct TPMessageRelationships {
	__unsafe_unretained NSString *conversation;
} TPMessageRelationships;

@class TPConversation;

@interface TPMessageID : TPSyncEntityID {}
@end

@interface _TPMessage : TPSyncEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPMessageID* objectID;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* from;

//- (BOOL)validateFrom:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* message;

//- (BOOL)validateMessage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* to;

//- (BOOL)validateTo:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TPConversation *conversation;

//- (BOOL)validateConversation:(id*)value_ error:(NSError**)error_;

@end

@interface _TPMessage (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (NSString*)primitiveFrom;
- (void)setPrimitiveFrom:(NSString*)value;

- (NSString*)primitiveMessage;
- (void)setPrimitiveMessage:(NSString*)value;

- (NSString*)primitiveTo;
- (void)setPrimitiveTo:(NSString*)value;

- (TPConversation*)primitiveConversation;
- (void)setPrimitiveConversation:(TPConversation*)value;

@end
