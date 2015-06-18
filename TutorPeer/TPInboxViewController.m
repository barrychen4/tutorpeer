//
//  TPInboxViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPInboxViewController.h"
#import "TPConversationViewController.h"
#import "TPNetworkManager+ContractRequests.h"
#import "TPNetworkManager+ConversationRequests.h"
#import <Parse/Parse.h>

@interface TPInboxViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *messages;

@end

@implementation TPInboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Inbox";
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self.view addSubview:_tableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[TPNetworkManager sharedInstance] refreshContractsForUserId:[PFUser currentUser].objectId withCallback:^(NSArray *objects, NSError *error) {
        NSLog(@"%@", objects);
        for (NSString *contractId in objects) {
            PFObject *contractPFObject = [PFQuery getObjectOfClass:@"Contract" objectId:contractId];
            [[TPNetworkManager sharedInstance] createConversationForContract:contractId withTutor:contractPFObject[@"tutor"] withTutee:contractPFObject[@"tutee"] withCallback:^(NSError *error) {
                
            }];
        }
    }];
}

#pragma mark - Table view data source methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageRow"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"messageRow"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Conversation %ld", (long)indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


#pragma mark - Table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TPConversationViewController *courseViewController = [[TPConversationViewController alloc] initWithConversation:[_tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    [self.navigationController pushViewController:courseViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
