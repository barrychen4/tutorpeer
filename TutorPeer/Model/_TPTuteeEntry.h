// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPTuteeEntry.h instead.

#import <CoreData/CoreData.h>
#import "TPSyncEntity.h"

extern const struct TPTuteeEntryRelationships {
	__unsafe_unretained NSString *course;
	__unsafe_unretained NSString *tutee;
} TPTuteeEntryRelationships;

@class TPCourse;
@class TPUser;

@interface TPTuteeEntryID : TPSyncEntityID {}
@end

@interface _TPTuteeEntry : TPSyncEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPTuteeEntryID* objectID;

@property (nonatomic, strong) TPCourse *course;

//- (BOOL)validateCourse:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TPUser *tutee;

//- (BOOL)validateTutee:(id*)value_ error:(NSError**)error_;

@end

@interface _TPTuteeEntry (CoreDataGeneratedPrimitiveAccessors)

- (TPCourse*)primitiveCourse;
- (void)setPrimitiveCourse:(TPCourse*)value;

- (TPUser*)primitiveTutee;
- (void)setPrimitiveTutee:(TPUser*)value;

@end
