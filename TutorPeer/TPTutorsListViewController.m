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

@property (strong, nonatomic) PFObject *courseObject;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *tutorEntries;

@end

@implementation TPTutorsListViewController

- (instancetype)initWithCourseObject:(PFObject *)courseObject {
    self = [super init];
    if (self) {
        _courseObject = courseObject;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"Tutor list for %@", _courseObject[@"courseName"]];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    PFQuery *query = [PFQuery queryWithClassName:@"TutorEntry"];
    [query whereKey:@"course" equalTo:_courseObject[@"courseCode"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            _tutorEntries = objects;
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
    PFObject *tutorEntry = _tutorEntries[indexPath.row];
    cell.textLabel.text = tutorEntry[@"tutor"];
    if ([tutorEntry[@"tutees"] containsObject:[PFUser currentUser].username]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tutorEntries count];
}

#pragma mark - Table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TPTuteeRegisterViewController *tuteeRegistraterController = [[TPTuteeRegisterViewController alloc] initWithTutorEntryObject:_tutorEntries[indexPath.row] courseObject:_courseObject];
    [self.navigationController pushViewController:tuteeRegistraterController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
