//
//  ViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/19/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Hello");
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.text = @"Hello";
    label.center = self.view.center;
    [self.view addSubview:label];
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"firstname"] = @"Ethan";
    testObject[@"lastname"] = @"Yu";
    testObject[@"username"] = @"ethanyu94";
    [testObject saveInBackground];
    
    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
    [query whereKey:@"username" equalTo:@"ethanyu94"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu objects.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"Object ID: %@, first name: %@, last name: %@", object.objectId, object[@"firstname"], object[@"lastname"]);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
