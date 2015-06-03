// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPUser.h instead.

#import <CoreData/CoreData.h>
#import "TPSyncEntity.h"

extern const struct TPUserAttributes {
	__unsafe_unretained NSString *defaultBio;
	__unsafe_unretained NSString *defaultPrice;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
} TPUserAttributes;

extern const struct TPUserRelationships {
	__unsafe_unretained NSString *contracts;
	__unsafe_unretained NSString *conversations;
	__unsafe_unretained NSString *tutorEntries;
} TPUserRelationships;

@class TPContract;
@class TPConversation;
@class TPTutorEntry;

@interface TPUserID : TPSyncEntityID {}
@end

@interface _TPUser : TPSyncEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPUserID* objectID;

@property (nonatomic, strong) NSString* defaultBio;

//- (BOOL)validateDefaultBio:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* defaultPrice;

@property (atomic) double defaultPriceValue;
- (double)defaultPriceValue;
- (void)setDefaultPriceValue:(double)value_;

//- (BOOL)validateDefaultPrice:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* email;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* firstName;

//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* lastName;

//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *contracts;

- (NSMutableSet*)contractsSet;

@property (nonatomic, strong) NSSet *conversations;

- (NSMutableSet*)conversationsSet;

@property (nonatomic, strong) NSSet *tutorEntries;

- (NSMutableSet*)tutorEntriesSet;

@end

@interface _TPUser (ContractsCoreDataGeneratedAccessors)
- (void)addContracts:(NSSet*)value_;
- (void)removeContracts:(NSSet*)value_;
- (void)addContractsObject:(TPContract*)value_;
- (void)removeContractsObject:(TPContract*)value_;

@end

@interface _TPUser (ConversationsCoreDataGeneratedAccessors)
- (void)addConversations:(NSSet*)value_;
- (void)removeConversations:(NSSet*)value_;
- (void)addConversationsObject:(TPConversation*)value_;
- (void)removeConversationsObject:(TPConversation*)value_;

@end

@interface _TPUser (TutorEntriesCoreDataGeneratedAccessors)
- (void)addTutorEntries:(NSSet*)value_;
- (void)removeTutorEntries:(NSSet*)value_;
- (void)addTutorEntriesObject:(TPTutorEntry*)value_;
- (void)removeTutorEntriesObject:(TPTutorEntry*)value_;

@end

@interface _TPUser (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveDefaultBio;
- (void)setPrimitiveDefaultBio:(NSString*)value;

- (NSNumber*)primitiveDefaultPrice;
- (void)setPrimitiveDefaultPrice:(NSNumber*)value;

- (double)primitiveDefaultPriceValue;
- (void)setPrimitiveDefaultPriceValue:(double)value_;

- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;

- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;

- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;

- (NSMutableSet*)primitiveContracts;
- (void)setPrimitiveContracts:(NSMutableSet*)value;

- (NSMutableSet*)primitiveConversations;
- (void)setPrimitiveConversations:(NSMutableSet*)value;

- (NSMutableSet*)primitiveTutorEntries;
- (void)setPrimitiveTutorEntries:(NSMutableSet*)value;

@end
