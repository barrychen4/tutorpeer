//
//  TPConversationView.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPConversationView.h"

@interface TPConversationView()

@property (strong, nonatomic) UILabel *messageLabel;

@end

@implementation TPConversationView

- (instancetype)initWithConversation:(NSString *)conversation {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.frame = CGRectMake(20, 200, 150, 150);
        _messageLabel.text = conversation;
        [self addSubview:_messageLabel];
    }
    return self;
}

@end
