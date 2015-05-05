// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TPUser.h instead.

#import <CoreData/CoreData.h>
#import "TPSyncEntity.h"

extern const struct TPUserAttributes {
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *profileImage;
} TPUserAttributes;

extern const struct TPUserRelationships {
	__unsafe_unretained NSString *tuteeCourses;
	__unsafe_unretained NSString *tutorCourses;
} TPUserRelationships;

@class TPCourse;
@class TPCourse;

@class NSObject;

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

@property (nonatomic, strong) id profileImage;

//- (BOOL)validateProfileImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *tuteeCourses;

- (NSMutableSet*)tuteeCoursesSet;

@property (nonatomic, strong) NSSet *tutorCourses;

- (NSMutableSet*)tutorCoursesSet;

@end

@interface _TPUser (TuteeCoursesCoreDataGeneratedAccessors)
- (void)addTuteeCourses:(NSSet*)value_;
- (void)removeTuteeCourses:(NSSet*)value_;
- (void)addTuteeCoursesObject:(TPCourse*)value_;
- (void)removeTuteeCoursesObject:(TPCourse*)value_;

@end

@interface _TPUser (TutorCoursesCoreDataGeneratedAccessors)
- (void)addTutorCourses:(NSSet*)value_;
- (void)removeTutorCourses:(NSSet*)value_;
- (void)addTutorCoursesObject:(TPCourse*)value_;
- (void)removeTutorCoursesObject:(TPCourse*)value_;

@end

@interface _TPUser (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;

- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;

- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;

- (id)primitiveProfileImage;
- (void)setPrimitiveProfileImage:(id)value;

- (NSMutableSet*)primitiveTuteeCourses;
- (void)setPrimitiveTuteeCourses:(NSMutableSet*)value;

- (NSMutableSet*)primitiveTutorCourses;
- (void)setPrimitiveTutorCourses:(NSMutableSet*)value;

@end
