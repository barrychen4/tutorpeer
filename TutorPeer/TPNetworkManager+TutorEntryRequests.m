//
//  TPNetworkManager+TutorEntryRequests.m
//  TutorPeer
//
//  Created by Yondon Fu on 6/16/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPNetworkManager+TutorEntryRequests.h"
#import "TPDBManager.h"
#import "TPUser.h"
#import "TPConstants.h"
#import <Parse/Parse.h>

@implementation TPNetworkManager (TutorEntryRequests)

- (void)refreshTutorEntriesForCourseId:(NSString *)courseId withCallback:(void (^)(NSError *))callback
{
    PFQuery *query;
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"course.objectId == %@", courseId];
    NSDate *latestDate = [[TPDBManager sharedInstance] latestDateForDBClass:@"TPTutorEntry" predicate:predicate1];
    NSPredicate *predicate2;
    if (latestDate) {
        predicate2 = [NSPredicate predicateWithFormat:@"(course == %@) AND (updatedAt > %@)", courseId, latestDate];
    } else {
        predicate2 = [NSPredicate predicateWithFormat:@"course == %@", courseId];
    }
    query = [PFQuery queryWithClassName:@"TutorEntry" predicate:predicate2];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error getting Parse tutor entries: %@", error);
            if (callback) {
                callback(error);
            }
        } else {
            if ([objects count]) {
                [[TPDBManager sharedInstance] addLocalObjectsForDBClass:@"TPTutorEntry" withRemoteObjects:objects];
                NSLog(@"Got %lu new tutor entries", [objects count]);
            }
            NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"course == %@", courseId];
            [self allParseObjectIDsForPFClass:@"TutorEntry" predicate:predicate3 withCallback:^(NSArray *objectIDArray, NSError *error) {
                if (objectIDArray) {
                    NSPredicate *predicate4 = [NSPredicate predicateWithFormat:@"course.objectId == %@", courseId];
                    [[TPDBManager sharedInstance] removeLocalObjectsNotOnParseForDBClass:@"TPTutorEntry" parseObjectIDs:objectIDArray predicate:predicate4];
                }
                if (callback) {
                    callback(nil);
                }
            }];
        }
    }];

}

- (void)registerAsTutorForCourseId:(NSString *)courseId withPrice:(NSInteger)price withBlurb:(NSString *)blurb withCallback:(void (^)(NSError *))callback
{
    PFObject *courseObject = [PFQuery getObjectOfClass:@"Course" objectId:courseId];
    if (!courseObject) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The course for this id doesn't exist.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check for a valid course id.", nil)
                                   };
        
        NSError *idError = [NSError errorWithDomain:@"TutorEntryError" code:800 userInfo:userInfo];
        
        if (callback) {
            callback(idError);
        }

    } else {
        PFObject *tutorEntryPFObject = [PFObject objectWithClassName:@"TutorEntry"];
        tutorEntryPFObject[@"course"] = courseId;
        tutorEntryPFObject[@"tutor"] = [TPUser currentUser].objectId;
        tutorEntryPFObject[@"tutorName"] = [NSString stringWithFormat:@"%@ %@", [TPUser currentUser].firstName, [TPUser currentUser].lastName];
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        tutorEntryPFObject[@"price"] = [NSNumber numberWithInteger:price];
        tutorEntryPFObject[@"blurb"] = blurb;
        
        [tutorEntryPFObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                if (succeeded) {
                    NSMutableArray *userTutorEntries = [NSMutableArray arrayWithArray:[PFUser currentUser][@"tutorEntries"]];
                    NSMutableArray *courseTutorEntries = [NSMutableArray arrayWithArray:courseObject[@"tutorEntries"]];
                    [userTutorEntries addObject:tutorEntryPFObject.objectId];
                    [courseTutorEntries addObject:tutorEntryPFObject.objectId];
                    [PFUser currentUser][@"tutorEntries"] = userTutorEntries;
                    courseObject[@"tutorEntries"] = courseTutorEntries;
                    
                    NSError *saveError;
                    [PFObject saveAll:@[[PFUser currentUser], courseObject] error:&saveError];
                    if (saveError) {
                        if (callback) {
                            callback(saveError);
                        }
                    }
                    
                    [[TPDBManager sharedInstance] updateLocalUser];
                    
                    if (callback) {
                        callback(nil);
                    }
                    
                } else {
                    NSLog(@"Save in background failed");
                }
            } else {
                NSLog(@"%@", [error localizedDescription]);
                if (callback) {
                    callback(error);
                }
            }
        }];
        
    }

}

- (void)updateTutorEntryWithId:(NSString *)tutorEntryId withPrice:(NSInteger)price withBlurb:(NSString *)blurb withCallback:(void (^)(NSError *))callback
{
    PFObject *tutorEntryPFObject = [PFQuery getObjectOfClass:@"TutorEntry" objectId:tutorEntryId];
    if (!tutorEntryPFObject) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The tutor entry for this id doesn't exist.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check for a valid tutor entry id.", nil)
                                   };
        
        NSError *idError = [NSError errorWithDomain:@"TutorEntryError" code:800 userInfo:userInfo];
        
        if (callback) {
            callback(idError);
        }
        
    } else {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        tutorEntryPFObject[@"price"] = [NSNumber numberWithInteger:price];
        tutorEntryPFObject[@"blurb"] = blurb;
        
        [tutorEntryPFObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                if (succeeded) {
                    if (callback) {
                        callback(nil);
                    }
                } else {
                    NSLog(@"Save in background failed");
                }
            } else {
                NSLog(@"%@", [error localizedDescription]);
                if (callback) {
                    callback(error);
                }
            }
        }];
        
    }

}

- (void)unregisterAsTutorWithId:(NSString *)tutorEntryId forCourseId:(NSString *)courseId withCallback:(void (^)(NSError *))callback
{
    PFObject *tutorEntryPFObject = [PFQuery getObjectOfClass:@"TutorEntry" objectId:tutorEntryId];
    if (!tutorEntryPFObject) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The tutor entry for this id doesn't exist.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check for a valid tutor entry id.", nil)
                                   };
        
        NSError *idError = [NSError errorWithDomain:@"TutorEntryError" code:800 userInfo:userInfo];
        
        if (callback) {
            callback(idError);
        }
    } else {
        PFObject *courseObject = [PFQuery getObjectOfClass:@"Course" objectId:courseId];
        if (!courseObject) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                       NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The course for this id doesn't exist.", nil),
                                       NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check for a valid course id.", nil)
                                       };
            
            NSError *idError = [NSError errorWithDomain:@"TutorEntryError" code:800 userInfo:userInfo];
            
            if (callback) {
                callback(idError);
            }
            
        } else {
            NSString *tutorEntryId = tutorEntryPFObject.objectId;
            NSError *error;
            [tutorEntryPFObject delete:&error];
            if (error) {
                if (callback) {
                    callback(error);
                }
            } else {
                NSMutableArray *userTutorEntries = [NSMutableArray arrayWithArray:[PFUser currentUser][@"tutorEntries"]];
                NSMutableArray *courseTutorEntries = [NSMutableArray arrayWithArray:courseObject[@"tutorEntries"]];
                [userTutorEntries removeObject:tutorEntryId];
                [courseTutorEntries removeObject:tutorEntryId];
                [PFUser currentUser][@"tutorEntries"] = userTutorEntries;
                courseObject[@"tutorEntries"] = courseTutorEntries;
                NSError *error;
                [PFObject saveAll:@[[PFUser currentUser], courseObject] error:&error];
                if (error) {
                    if (callback) {
                        callback(error);
                    }
                }
                [[TPDBManager sharedInstance] updateLocalUser];

                if (callback) {
                    callback(nil);
                }
            }
        }
    }
    
}

- (void)registerAsTutee:(NSString *)tuteeId withTutor:(NSString *)tutorId forCourse:(NSString *)courseId withPrice:(NSInteger)price withCallback:(void (^)(NSError *))callback
{
    PFObject *courseObject = [PFQuery getObjectOfClass:@"Course" objectId:courseId];
    if (!courseObject) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The course for this id doesn't exist.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check for a valid course id.", nil)
                                   };
        
        NSError *idError = [NSError errorWithDomain:@"TutorEntryError" code:800 userInfo:userInfo];
        
        if (callback) {
            callback(idError);
        }
    } else {
        PFObject *contractPFObject = [PFObject objectWithClassName:@"Contract"];
        contractPFObject[@"price"] = [NSNumber numberWithInteger:price];
        contractPFObject[@"course"] = courseId;
        contractPFObject[@"tutor"] = tutorId;
        contractPFObject[@"tutee"] = tuteeId;
        contractPFObject[@"status"] = @(TPContractStatusInitiated);
        
        [contractPFObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                if (succeeded) {
                    NSMutableArray *userContracts = [NSMutableArray arrayWithArray:[PFUser currentUser][@"contracts"]];
                    NSMutableArray *courseContracts = [NSMutableArray arrayWithArray:courseObject[@"contracts"]];
                    [userContracts addObject:contractPFObject.objectId];
                    [courseContracts addObject:contractPFObject.objectId];
                    [PFUser currentUser][@"contracts"] = userContracts;
                    courseObject[@"contracts"] = courseContracts;
                    
                    NSError *saveError;
                    [PFObject saveAll:@[[PFUser currentUser], courseObject] error:&saveError];
                    if (saveError) {
                        if (callback) {
                            callback(saveError);
                        }
                    }
                    
                    [[TPDBManager sharedInstance] updateLocalUser];
                    
                    if (callback) {
                        callback(nil);
                    }
                    
                } else {
                    
                }
            } else {
                if (callback) {
                    callback(error);
                }
            }
        }];

    }

}

- (void)unregisterAsTuteeForCourse:(NSString *)courseId forContract:(NSString *)contractId withCallback:(void (^)(NSError *))callback
{
    PFObject *courseObject = [PFQuery getObjectOfClass:@"Course" objectId:courseId];
    if (!courseObject) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The course for this id doesn't exist.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check for a valid course id.", nil)
                                   };
        
        NSError *idError = [NSError errorWithDomain:@"TutorEntryError" code:800 userInfo:userInfo];
        
        if (callback) {
            callback(idError);
        }
    } else {
        PFObject *contractPFObject = [PFQuery getObjectOfClass:@"Contract" objectId:contractId];
        if (!contractPFObject) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                       NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The contract for this id doesn't exist.", nil),
                                       NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Check for a valid contract id.", nil)
                                       };
            
            NSError *idError = [NSError errorWithDomain:@"TutorEntryError" code:800 userInfo:userInfo];
            
            if (callback) {
                callback(idError);
            }
        } else {
            NSString *contractId = contractPFObject.objectId;
            [contractPFObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    if (succeeded) {
                        NSMutableArray *userContracts = [NSMutableArray arrayWithArray:[PFUser currentUser][@"contracts"]];
                        NSMutableArray *courseContracts = [NSMutableArray arrayWithArray:courseObject[@"contracts"]];
                        [userContracts removeObject:contractId];
                        [courseContracts removeObject:contractId];
                        [PFUser currentUser][@"contracts"] = userContracts;
                        courseObject[@"contracts"] = courseContracts;
                        
                        NSError *saveError;
                        [PFObject saveAll:@[[PFUser currentUser], courseObject] error:&saveError];
                        if (saveError) {
                            if (callback) {
                                callback(saveError);
                            }
                        }
                        [[TPDBManager sharedInstance] updateLocalUser];
                        
                        if (callback) {
                            callback(nil);
                        }

                    } else {
                        
                    }
                } else {
                    if (callback) {
                        callback(error);
                    }
                }
            }];
        }

    }

}

@end
