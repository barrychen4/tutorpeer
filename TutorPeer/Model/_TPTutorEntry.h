// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPTutorEntry.h instead.

#import <CoreData/CoreData.h>
#import "TPSyncEntity.h"

extern const struct TPTutorEntryAttributes {
	__unsafe_unretained NSString *blurb;
	__unsafe_unretained NSString *price;
} TPTutorEntryAttributes;

extern const struct TPTutorEntryRelationships {
	__unsafe_unretained NSString *course;
	__unsafe_unretained NSString *tutor;
} TPTutorEntryRelationships;

@class TPCourse;
@class TPUser;

@interface TPTutorEntryID : TPSyncEntityID {}
@end

@interface _TPTutorEntry : TPSyncEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPTutorEntryID* objectID;

@property (nonatomic, strong) NSString* blurb;

//- (BOOL)validateBlurb:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* price;

@property (atomic) double priceValue;
- (double)priceValue;
- (void)setPriceValue:(double)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TPCourse *course;

//- (BOOL)validateCourse:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TPUser *tutor;

//- (BOOL)validateTutor:(id*)value_ error:(NSError**)error_;

@end

@interface _TPTutorEntry (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveBlurb;
- (void)setPrimitiveBlurb:(NSString*)value;

- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (double)primitivePriceValue;
- (void)setPrimitivePriceValue:(double)value_;

- (TPCourse*)primitiveCourse;
- (void)setPrimitiveCourse:(TPCourse*)value;

- (TPUser*)primitiveTutor;
- (void)setPrimitiveTutor:(TPUser*)value;

@end
