//
//  TPNetworkManager+TPCourseRequests.m
//  TutorPeer
//
//  Created by Yondon Fu on 5/10/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager+TPCourseRequests.h"
#import <Parse/Parse.h>

@implementation TPNetworkManager (TPCourseRequests)

- (void)getCoursesWithCallback:(void (^)(NSArray *))callback
{
    PFQuery *query = [PFQuery queryWithClassName:@"Course"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            // Add locally
            NSEntityDescription *e = [NSEntityDescription entityForName:@"TPCourse" inManagedObjectContext:self.managedObjectContext];
            
            NSDictionary *localObjects = [self addLocalObjectsForClass:e withRemoteObjects:objects];
            
            for (PFObject *parseObject in objects) {
                TPCourse *course = [localObjects objectForKey:parseObject.objectId];
                [course setValue:parseObject[@"courseName"] forKey:@"courseName"];
                [course setValue:parseObject[@"courseCode"] forKey:@"courseCode"];
            }
            
            NSLog(@"Added objects locally");
            
            NSArray *objectIds = [objects valueForKeyPath:@"objectId"];
            
            NSArray *locals = [self getLocalObjectsForClass:e withRemoteIds:objectIds];
            
            if (locals.count != 0) {
                
                for (TPCourse *course in locals) {
                    NSLog(@"%@", course.courseName);
                    NSLog(@"%@", course.courseCode);
                }
                
            } else {
                NSLog(@"empty");
            }
            
            callback(objects);
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

@end
