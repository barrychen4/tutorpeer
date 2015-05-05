// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPCourse.h instead.

#import <CoreData/CoreData.h>

extern const struct TPCourseAttributes {
	__unsafe_unretained NSString *courseCode;
	__unsafe_unretained NSString *courseName;
} TPCourseAttributes;

extern const struct TPCourseRelationships {
	__unsafe_unretained NSString *tutees;
	__unsafe_unretained NSString *tutors;
} TPCourseRelationships;

@class TPUser;
@class TPUser;

@interface TPCourseID : NSManagedObjectID {}
@end

@interface _TPCourse : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TPCourseID* objectID;

@property (nonatomic, strong) NSString* courseCode;

//- (BOOL)validateCourseCode:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* courseName;

//- (BOOL)validateCourseName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *tutees;

- (NSMutableSet*)tuteesSet;

@property (nonatomic, strong) NSSet *tutors;

- (NSMutableSet*)tutorsSet;

@end

@interface _TPCourse (TuteesCoreDataGeneratedAccessors)
- (void)addTutees:(NSSet*)value_;
- (void)removeTutees:(NSSet*)value_;
- (void)addTuteesObject:(TPUser*)value_;
- (void)removeTuteesObject:(TPUser*)value_;

@end

@interface _TPCourse (TutorsCoreDataGeneratedAccessors)
- (void)addTutors:(NSSet*)value_;
- (void)removeTutors:(NSSet*)value_;
- (void)addTutorsObject:(TPUser*)value_;
- (void)removeTutorsObject:(TPUser*)value_;

@end

@interface _TPCourse (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCourseCode;
- (void)setPrimitiveCourseCode:(NSString*)value;

- (NSString*)primitiveCourseName;
- (void)setPrimitiveCourseName:(NSString*)value;

- (NSMutableSet*)primitiveTutees;
- (void)setPrimitiveTutees:(NSMutableSet*)value;

- (NSMutableSet*)primitiveTutors;
- (void)setPrimitiveTutors:(NSMutableSet*)value;

@end
