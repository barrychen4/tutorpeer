//
//  TPTutorsListViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 5/10/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPTutorsListViewController.h"
#import "TPTuteeRegisterViewController.h"
#import <Parse/Parse.h>

@interface TPTutorsListViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) PFObject *courseObject;
@property (strong, nonatomic) NSArray *tutors;

@end

@implementation TPTutorsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Courses";
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    PFQuery *query = [PFQuery queryWithClassName:@"TutorEntry"];
    [query whereKey:@"course" equalTo:_courseObject[@"courseCode"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            _tutors = objects;
            [_tableView reloadData];
            // NSLog(@"Found courses %@", _courses);
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self.view addSubview:_tableView];
}

#pragma mark - Table view data source methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tutorRow"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tutorRow"];
    }
    PFObject *tutor = _tutors[indexPath.row];
    cell.textLabel.text = tutor[@"tutor"];
    if ([tutor[@"tutees"] containsString:[PFUser currentUser].username]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tutors count];
}

#pragma mark - Table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TPTuteeRegisterViewController *tuteeRegistraterController = [[TPTuteeRegisterViewController alloc] initWithPFObject:_tutors[indexPath.row]];
    [self.navigationController pushViewController:tuteeRegistraterController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
