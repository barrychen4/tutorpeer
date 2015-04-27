//
//  TPInboxViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPInboxViewController.h"
#import "TPConversationViewController.h"

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
    //return [self.messages count];
    return 20;
}


#pragma mark - Table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TPConversationViewController *courseViewController = [[TPConversationViewController alloc] initWithConversation:[_tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    [self.navigationController pushViewController:courseViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
