//
//  TPContractViewController.h
//  TutorPeer
//
//  Created by Yondon Fu on 7/15/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPContract.h"

@interface TPContractViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithContractObject:(TPContract *)contract;

@end
