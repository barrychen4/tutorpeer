//
//  TPCourse.h
//  TutorPeer
//
//  Created by Yondon Fu on 5/3/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TPUser;

@interface TPCourse : NSManagedObject

@property (nonatomic, retain) NSString * courseCode;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSSet *tutees;
@property (nonatomic, retain) NSSet *tutors;

@end

@interface TPCourse (CoreDataGeneratedAccessors)

- (void)addTuteesObject:(TPUser *)value;
- (void)removeTuteesObject:(TPUser *)value;
- (void)addTutees:(NSSet *)values;
- (void)removeTutees:(NSSet *)values;

- (void)addTutorsObject:(TPUser *)value;
- (void)removeTutorsObject:(TPUser *)value;
- (void)addTutors:(NSSet *)values;
- (void)removeTutors:(NSSet *)values;

@end
