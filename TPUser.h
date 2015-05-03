//
//  TPUser.h
//  TutorPeer
//
//  Created by Yondon Fu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class TPCourse;

@interface TPUser : NSManagedObject

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) UIImage *profileImage;
@property (nonatomic, retain) NSSet *tutorCourses;
@property (nonatomic, retain) NSSet *tuteeCourses;

@end

@interface TPUser (CoreDataGeneratedAccessors)

- (void)addTutorCoursesObject:(TPCourse *)value;
- (void)removeTutorCoursesObject:(TPCourse *)value;
- (void)addTutorCourses:(NSSet *)values;
- (void)removeTutorCourses:(NSSet *)values;

- (void)addTuteeCoursesObject:(TPCourse *)value;
- (void)removeTuteeCoursesObject:(TPCourse *)value;
- (void)addTuteeCourses:(NSSet *)values;
- (void)removeTuteeCourses:(NSSet *)values;

@end
