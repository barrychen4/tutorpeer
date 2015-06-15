//
//  TPSettingsViewController.m
//  TutorPeer
//
//  Created by Yondon Fu on 6/15/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPSettingsViewController.h"
#import "TPUser.h"
#import "AppDelegate.h"

@interface TPSettingsViewController ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation TPSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.title =  @"Settings";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingsRow"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"settingsRow"];
    }
    
    cell.textLabel.text = @"Logout";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Clicked logout");
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate logOutUser];
}

@end
