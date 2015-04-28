//
//  TPMessage.h
//  TutorPeer
//
//  Created by Ethan Yu on 4/27/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPMessage : NSObject

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSDate *date;

@end
