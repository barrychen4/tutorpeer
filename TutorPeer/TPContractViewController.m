//
//  TPContractViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 7/15/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPContractViewController.h"
#import "TPContract.h"
#import "TPCourse.h"
#import "TPUser.h"

@interface TPContractViewController ()

@property (strong, nonatomic) TPContract *contract;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *confirmButton;

@end

@implementation TPContractViewController

- (instancetype)initWithContractObject:(TPContract *)contract
{
    self = [super init];
    if (self) {
        self.contract = contract;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.title = @"Contract";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
}

#pragma mark UITableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contractRow"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contractRow"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", self.contract.course.courseCode, self.contract.course.courseName];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"Price: %@", self.contract.price];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = [NSString stringWithFormat:@"Tutor: %@ %@", self.contract.tutor.firstName, self.contract.tutor.lastName];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"Tutee: %@ %@", self.contract.tutee.firstName, self.contract.tutee.lastName];
    }
    
    return cell;
}


@end
