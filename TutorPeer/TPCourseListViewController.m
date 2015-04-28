//
//  TPCourseListViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPCourseListViewController.h"
#import "TPCourseViewController.h"
#import "TPCourse.h"

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
    [self.view addSubview:_tableView];
}


#pragma mark - Table view data source methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"courseRow"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"courseRow"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Course %ld", (long)indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.courses count];
    return 20;
}

#pragma mark - Table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TPCourse *course = [[TPCourse alloc] init];
    course.courseName = [_tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    TPCourseViewController *courseViewController = [[TPCourseViewController alloc] initWithCourse:course];
    [self.navigationController pushViewController:courseViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}

@end
