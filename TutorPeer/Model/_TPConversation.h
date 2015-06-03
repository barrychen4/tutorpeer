// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPConversation.h instead.

#import <CoreData/CoreData.h>
#import "TPSyncEntity.h"

extern const struct TPConversationRelationships {
	__unsafe_unretained NSString *contract;
	__unsafe_unretained NSString *messages;
	__unsafe_unretained NSString *participants;
} TPConversationRelationships;

@class TPContract;
@class TPMessage;
@class TPUser;

@interface TPConversationID : TPSyncEntityID {}
@end

@interface _TPConversation : TPSyncEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPConversationID* objectID;

@property (nonatomic, strong) TPContract *contract;

//- (BOOL)validateContract:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *messages;

- (NSMutableSet*)messagesSet;

@property (nonatomic, strong) NSSet *participants;

- (NSMutableSet*)participantsSet;

@end

@interface _TPConversation (MessagesCoreDataGeneratedAccessors)
- (void)addMessages:(NSSet*)value_;
- (void)removeMessages:(NSSet*)value_;
- (void)addMessagesObject:(TPMessage*)value_;
- (void)removeMessagesObject:(TPMessage*)value_;

@end

@interface _TPConversation (ParticipantsCoreDataGeneratedAccessors)
- (void)addParticipants:(NSSet*)value_;
- (void)removeParticipants:(NSSet*)value_;
- (void)addParticipantsObject:(TPUser*)value_;
- (void)removeParticipantsObject:(TPUser*)value_;

@end

@interface _TPConversation (CoreDataGeneratedPrimitiveAccessors)

- (TPContract*)primitiveContract;
- (void)setPrimitiveContract:(TPContract*)value;

- (NSMutableSet*)primitiveMessages;
- (void)setPrimitiveMessages:(NSMutableSet*)value;

- (NSMutableSet*)primitiveParticipants;
- (void)setPrimitiveParticipants:(NSMutableSet*)value;

@end
