//
//  TPCourse.h
//  TutorPeer
//
//  Created by Ethan Yu on 4/27/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPCourse : NSObject

@property (strong, nonatomic) NSString *courseCode;
@property (strong, nonatomic) NSString *courseName;
@property (strong, nonatomic) NSArray *tutors;
@property (strong, nonatomic) NSArray *tutees; 

@end
