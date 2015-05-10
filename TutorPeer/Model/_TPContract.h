// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPContract.h instead.

#import <CoreData/CoreData.h>
#import "TPSyncEntity.h"

extern const struct TPContractAttributes {
	__unsafe_unretained NSString *hrsWeek;
	__unsafe_unretained NSString *price;
} TPContractAttributes;

extern const struct TPContractRelationships {
	__unsafe_unretained NSString *course;
	__unsafe_unretained NSString *tutee;
	__unsafe_unretained NSString *tutor;
} TPContractRelationships;

@class TPCourse;
@class TPUser;
@class TPUser;

@interface TPContractID : TPSyncEntityID {}
@end

@interface _TPContract : TPSyncEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPContractID* objectID;

@property (nonatomic, strong) NSNumber* hrsWeek;

@property (atomic) int32_t hrsWeekValue;
- (int32_t)hrsWeekValue;
- (void)setHrsWeekValue:(int32_t)value_;

//- (BOOL)validateHrsWeek:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* price;

@property (atomic) double priceValue;
- (double)priceValue;
- (void)setPriceValue:(double)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TPCourse *course;

//- (BOOL)validateCourse:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TPUser *tutee;

//- (BOOL)validateTutee:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TPUser *tutor;

//- (BOOL)validateTutor:(id*)value_ error:(NSError**)error_;

@end

@interface _TPContract (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveHrsWeek;
- (void)setPrimitiveHrsWeek:(NSNumber*)value;

- (int32_t)primitiveHrsWeekValue;
- (void)setPrimitiveHrsWeekValue:(int32_t)value_;

- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (double)primitivePriceValue;
- (void)setPrimitivePriceValue:(double)value_;

- (TPCourse*)primitiveCourse;
- (void)setPrimitiveCourse:(TPCourse*)value;

- (TPUser*)primitiveTutee;
- (void)setPrimitiveTutee:(TPUser*)value;

- (TPUser*)primitiveTutor;
- (void)setPrimitiveTutor:(TPUser*)value;

@end
