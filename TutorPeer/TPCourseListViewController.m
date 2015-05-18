//
//  TPCourseListViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPCourseListViewController.h"
#import "TPCourseViewController.h"
#import <Parse/Parse.h>
#import "TPNetworkManager+TPCourseRequests.h"

@interface TPCourseListViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *courses;

@end

@implementation TPCourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Courses";
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [[TPNetworkManager sharedInstance] getCoursesWithCallback:^(NSArray *courses) {
        _courses = courses;
        [_tableView reloadData];
        
        NSLog(@"Successfuly got courses with callback");
    }];
    
    [self.view addSubview:_tableView];
}


#pragma mark - Table view data source methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"courseRow"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"courseRow"];
    }
    PFObject *course = _courses[indexPath.row];
    cell.textLabel.text = course[@"courseName"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_courses count];
}

#pragma mark - Table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TPCourse *course = _courses[indexPath.row];
    TPCourseViewController *courseViewController = [[TPCourseViewController alloc] initWithCourseObject:_courses[indexPath.row]];
    [self.navigationController pushViewController:courseViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}

@end
