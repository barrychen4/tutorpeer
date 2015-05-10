// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPCourse.h instead.

#import <CoreData/CoreData.h>
#import "TPSyncEntity.h"

extern const struct TPCourseAttributes {
	__unsafe_unretained NSString *courseCode;
	__unsafe_unretained NSString *courseName;
} TPCourseAttributes;

extern const struct TPCourseRelationships {
	__unsafe_unretained NSString *contracts;
	__unsafe_unretained NSString *tuteeEntries;
	__unsafe_unretained NSString *tutorEntries;
} TPCourseRelationships;

@class TPContract;
@class TPTuteeEntry;
@class TPTutorEntry;

@interface TPCourseID : TPSyncEntityID {}
@end

@interface _TPCourse : TPSyncEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPCourseID* objectID;

@property (nonatomic, strong) NSString* courseCode;

//- (BOOL)validateCourseCode:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* courseName;

//- (BOOL)validateCourseName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *contracts;

- (NSMutableSet*)contractsSet;

@property (nonatomic, strong) NSSet *tuteeEntries;

- (NSMutableSet*)tuteeEntriesSet;

@property (nonatomic, strong) NSSet *tutorEntries;

- (NSMutableSet*)tutorEntriesSet;

@end

@interface _TPCourse (ContractsCoreDataGeneratedAccessors)
- (void)addContracts:(NSSet*)value_;
- (void)removeContracts:(NSSet*)value_;
- (void)addContractsObject:(TPContract*)value_;
- (void)removeContractsObject:(TPContract*)value_;

@end

@interface _TPCourse (TuteeEntriesCoreDataGeneratedAccessors)
- (void)addTuteeEntries:(NSSet*)value_;
- (void)removeTuteeEntries:(NSSet*)value_;
- (void)addTuteeEntriesObject:(TPTuteeEntry*)value_;
- (void)removeTuteeEntriesObject:(TPTuteeEntry*)value_;

@end

@interface _TPCourse (TutorEntriesCoreDataGeneratedAccessors)
- (void)addTutorEntries:(NSSet*)value_;
- (void)removeTutorEntries:(NSSet*)value_;
- (void)addTutorEntriesObject:(TPTutorEntry*)value_;
- (void)removeTutorEntriesObject:(TPTutorEntry*)value_;

@end

@interface _TPCourse (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCourseCode;
- (void)setPrimitiveCourseCode:(NSString*)value;

- (NSString*)primitiveCourseName;
- (void)setPrimitiveCourseName:(NSString*)value;

- (NSMutableSet*)primitiveContracts;
- (void)setPrimitiveContracts:(NSMutableSet*)value;

- (NSMutableSet*)primitiveTuteeEntries;
- (void)setPrimitiveTuteeEntries:(NSMutableSet*)value;

- (NSMutableSet*)primitiveTutorEntries;
- (void)setPrimitiveTutorEntries:(NSMutableSet*)value;

@end
