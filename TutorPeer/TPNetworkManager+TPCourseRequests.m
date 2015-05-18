//
//  TPNetworkManager+TPCourseRequests.m
//  TutorPeer
//
//  Created by Yondon Fu on 5/10/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager+TPCourseRequests.h"
#import <Parse/Parse.h>
#import "TPCourse.h"
#import "TPTutorEntry.h"

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
            
            callback(objects);
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (void)getTutorEntryFor:(NSString *)username andCourse:(NSString *)courseCode withCallback:(void (^)(NSArray *))callback
{
    PFQuery *query = [PFQuery queryWithClassName:@"TutorEntry"];
    [query whereKey:@"tutor" equalTo:username];
    [query whereKey:@"course" equalTo:courseCode];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSEntityDescription *e = [NSEntityDescription entityForName:@"TPTutorEntry" inManagedObjectContext:self.managedObjectContext];
            
            NSArray *remoteObject = [NSArray arrayWithObject:objects[0]];
            
            NSDictionary *localObjects = [self addLocalObjectsForClass:e withRemoteObjects:remoteObject];
            
            for (PFObject *parseObject in objects) {
                TPTutorEntry *tutorEntry = [localObjects objectForKey:parseObject.objectId];
//                [tutorEntry setValue:parseObject[@"tutor"] forKey:@"tutor"];
//                [tutorEntry setValue:parseObject[@"course"] forKey:@"course"];
                [tutorEntry setValue:parseObject[@"price"] forKey:@"price"];
                [tutorEntry setValue:parseObject[@"blurb"] forKey:@"blurb"];
            }
            
            NSLog(@"Added objects locally");
            
            callback(remoteObject);
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)getTuteeEntryFor:(NSString *)username andCourse:(NSString *)courseCode andTutor:(NSString *)tutor withCallback:(void (^)(NSArray *))callback
{
    PFQuery *query = [PFQuery queryWithClassName:@"TuteeEntry"];
    [query whereKey:@"tutee" equalTo:username];
    [query whereKey:@"course" equalTo:courseCode];
    [query whereKey:@"tutor" equalTo:tutor];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSEntityDescription *e = [NSEntityDescription entityForName:@"TPTuteeEntry" inManagedObjectContext:self.managedObjectContext];
            
            NSArray *remoteObject = [NSArray arrayWithObject:objects[0]];
            
            NSDictionary *localObjects = [self addLocalObjectsForClass:e withRemoteObjects:remoteObject];
            
            for (PFObject *parseObject in objects) {
                TPTuteeEntry *tuteeEntry = [localObjects objectForKey:parseObject.objectId];
                //                [tutorEntry setValue:parseObject[@"tutor"] forKey:@"tutor"];
                //                [tutorEntry setValue:parseObject[@"course"] forKey:@"course"];
//                [tutorEntry setValue:parseObject[@"price"] forKey:@"price"];
//                [tutorEntry setValue:parseObject[@"blurb"] forKey:@"blurb"];
            }
            
            NSLog(@"Added objects locally");
            
            callback(remoteObject);
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}





@end
