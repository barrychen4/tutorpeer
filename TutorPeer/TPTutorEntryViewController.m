//
//  TPTutorEntryViewController.m
//  TutorPeer
//
//  Created by Ethan Yu on 6/4/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "TPTutorEntryViewController.h"
#import "TPTutorEntry.h"

@interface TPTutorEntryViewController ()

@property (strong, nonatomic) TPTutorEntry* tutorEntry;

@end

@implementation TPTutorEntryViewController

- (instancetype)initWithTutorEntry:(TPTutorEntry *)tutorEntry {
    self = [super init];
    if (self) {
        self.tutorEntry = tutorEntry;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
