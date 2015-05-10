// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPUser.h instead.

#import <CoreData/CoreData.h>
#import "TPSyncEntity.h"

extern const struct TPUserAttributes {
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
} TPUserAttributes;

extern const struct TPUserRelationships {
	__unsafe_unretained NSString *tuteeContracts;
	__unsafe_unretained NSString *tuteeEntries;
	__unsafe_unretained NSString *tutorContracts;
	__unsafe_unretained NSString *tutorEntries;
} TPUserRelationships;

@class TPContract;
@class TPTuteeEntry;
@class TPContract;
@class TPTutorEntry;

@interface TPUserID : TPSyncEntityID {}
@end

@interface _TPUser : TPSyncEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPUserID* objectID;

@property (nonatomic, strong) NSString* email;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* firstName;

//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* lastName;

//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *tuteeContracts;

- (NSMutableSet*)tuteeContractsSet;

@property (nonatomic, strong) NSSet *tuteeEntries;

- (NSMutableSet*)tuteeEntriesSet;

@property (nonatomic, strong) NSSet *tutorContracts;

- (NSMutableSet*)tutorContractsSet;

@property (nonatomic, strong) NSSet *tutorEntries;

- (NSMutableSet*)tutorEntriesSet;

@end

@interface _TPUser (TuteeContractsCoreDataGeneratedAccessors)
- (void)addTuteeContracts:(NSSet*)value_;
- (void)removeTuteeContracts:(NSSet*)value_;
- (void)addTuteeContractsObject:(TPContract*)value_;
- (void)removeTuteeContractsObject:(TPContract*)value_;

@end

@interface _TPUser (TuteeEntriesCoreDataGeneratedAccessors)
- (void)addTuteeEntries:(NSSet*)value_;
- (void)removeTuteeEntries:(NSSet*)value_;
- (void)addTuteeEntriesObject:(TPTuteeEntry*)value_;
- (void)removeTuteeEntriesObject:(TPTuteeEntry*)value_;

@end

@interface _TPUser (TutorContractsCoreDataGeneratedAccessors)
- (void)addTutorContracts:(NSSet*)value_;
- (void)removeTutorContracts:(NSSet*)value_;
- (void)addTutorContractsObject:(TPContract*)value_;
- (void)removeTutorContractsObject:(TPContract*)value_;

@end

@interface _TPUser (TutorEntriesCoreDataGeneratedAccessors)
- (void)addTutorEntries:(NSSet*)value_;
- (void)removeTutorEntries:(NSSet*)value_;
- (void)addTutorEntriesObject:(TPTutorEntry*)value_;
- (void)removeTutorEntriesObject:(TPTutorEntry*)value_;

@end

@interface _TPUser (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;

- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;

- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;

- (NSMutableSet*)primitiveTuteeContracts;
- (void)setPrimitiveTuteeContracts:(NSMutableSet*)value;

- (NSMutableSet*)primitiveTuteeEntries;
- (void)setPrimitiveTuteeEntries:(NSMutableSet*)value;

- (NSMutableSet*)primitiveTutorContracts;
- (void)setPrimitiveTutorContracts:(NSMutableSet*)value;

- (NSMutableSet*)primitiveTutorEntries;
- (void)setPrimitiveTutorEntries:(NSMutableSet*)value;

@end
