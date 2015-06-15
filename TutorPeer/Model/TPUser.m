#import "TPUser.h"
#import "TPDBManager.h"
#import <Parse/Parse.h>

@interface TPUser ()

// Private interface goes here.

@end

static TPUser *_currentUser;

@implementation TPUser

// Custom logic goes here.

+ (TPUser *)currentUser {
    if (!_currentUser) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"loggedIn == YES"];
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"TPUser"];
        request.predicate = predicate;
        request.fetchLimit = 1;
        
        NSError *error;
        NSArray *objects = [[TPDBManager sharedInstance].managedObjectContext executeFetchRequest:request error:&error];
        if ([objects count]) {
            _currentUser = objects[0];
        }
    }
    return _currentUser;
}

+ (void)logOut {
    _currentUser = nil;
    
    [PFUser logOut];
}

@end
