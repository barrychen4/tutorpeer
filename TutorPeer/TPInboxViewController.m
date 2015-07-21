//
//  TPInboxViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPInboxViewController.h"
#import "TPConversationViewController.h"
#import "TPContractViewController.h"
#import "TPNetworkManager+ContractRequests.h"
#import "TPNetworkManager+ConversationRequests.h"
#import "TPUser.h"
#import "TPContract.h"
#import <Parse/Parse.h>

@interface TPInboxViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *controlScrollView;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSArray *conversations;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TPInboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Inbox";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _controlScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height - 15, self.view.frame.size.width, 40)];
    _controlScrollView.backgroundColor = [UIColor clearColor];

    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Initiated", @"Confirmed"]];
    _segmentedControl.frame = CGRectMake(0, 0, 300, 25);
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl setCenter:_controlScrollView.center];
    [_controlScrollView addSubview:_segmentedControl];
    
    [self.view addSubview:_controlScrollView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + _controlScrollView.frame.size.height + 30, self.view.frame.size.width, self.view.frame.size.height)];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self.view addSubview:_tableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[TPNetworkManager sharedInstance] refreshConversationsForUserId:[PFUser currentUser].objectId withCallback:^(NSError *error) {
        self.conversations = [[TPUser currentUser].conversations allObjects];
        
        NSLog(@"Conversations: %@", self.conversations);
        NSLog(@"# Conversations: %lu", self.conversations.count);
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageRow"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"messageRow"];
    }
    
    if ([[TPUser currentUser].objectId isEqualToString:((TPConversation *)self.conversations[indexPath.row]).contract.tutee.objectId]) {
        // I am a tutee
        cell.textLabel.text = [NSString stringWithFormat:@"Conversation with %@ %@", ((TPConversation *)self.conversations[indexPath.row]).contract.tutor.firstName, ((TPConversation *)self.conversations[indexPath.row]).contract.tutor.lastName];
        cell.backgroundColor = [UIColor blueColor];
        
    } else {
        // I am a tutor
        cell.textLabel.text = [NSString stringWithFormat:@"Conversation with %@ %@", ((TPConversation *)self.conversations[indexPath.row]).contract.tutee.firstName, ((TPConversation *)self.conversations[indexPath.row]).contract.tutee.lastName];
        cell.backgroundColor = [UIColor greenColor];
    
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conversations.count;
}


#pragma mark - Table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TPContract *contract = ((TPConversation *)self.conversations[indexPath.row]).contract;
    
    TPContractViewController *contractVc = [[TPContractViewController alloc] initWithContractObject:contract];
    [self.navigationController pushViewController:contractVc animated:YES];
}

@end
