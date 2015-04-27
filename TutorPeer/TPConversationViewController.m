//
//  TPConversationViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/26/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPConversationViewController.h"
#import "TPConversationView.h"

@interface TPConversationViewController ()

@end

@implementation TPConversationViewController

- (instancetype)initWithConversation:(NSString *)conversation {
    self = [super init];
    if (self) {
        self.view = [[TPConversationView alloc] initWithConversation:conversation];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
