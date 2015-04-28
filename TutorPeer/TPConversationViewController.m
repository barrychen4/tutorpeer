//
//  TPConversationViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPConversationViewController.h"
#import "TPMessage.h"
#import "TPConversation.h"

@interface TPConversationViewController ()

@property (strong, nonatomic) TPConversation *conversation;
@property (strong, nonatomic) UILabel *messageLabel;

@end

@implementation TPConversationViewController

- (instancetype)initWithConversation:(TPConversation *)conversation {
    self = [super init];
    if (self) {
        _conversation = conversation;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.frame = CGRectMake(20, 200, 400, 150);
    _messageLabel.text = @"Conversation messages go here";
    [self.view addSubview:_messageLabel];
}

@end
