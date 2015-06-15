//
//  AppDelegate.m
//  TutorPeer
//
//  Created by Ethan Yu on 4/19/15.
//  Copyright (c) 2015 TutorPeer. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "TPLandingViewController.h"
#import "TPInboxViewController.h"
#import "TPCourseListViewController.h"
#import "TPProfileViewController.h"
#import "TPDBManager.h"
#import "TPUser.h"
#import "TPNetworkManager.h"
#import "TPTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [Parse enableLocalDatastore];
    [Parse setApplicationId:@"um93eOoLG7dNZ6qRzwrTxO5zHAqIQly9J4zAz9gS"
                  clientKey:@"hqMGjaVFPYIUkO2322TgIoI10fGyiv8qvcOqurTg"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    if (![TPUser currentUser]) {
        TPLandingViewController *landingVc = [[TPLandingViewController alloc] init];
        
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:landingVc];
        
        self.window.rootViewController = self.navigationController;
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    } else {
        [[TPNetworkManager sharedInstance] refreshContractsForUserId:[PFUser currentUser].objectId withCallback:nil async:YES];
        
        UINavigationController *inboxViewController = [[UINavigationController alloc] initWithRootViewController:[[TPInboxViewController alloc] init]];
        UINavigationController *courseViewController = [[UINavigationController alloc] initWithRootViewController:[[TPCourseListViewController alloc] init]];
        UINavigationController *profileViewController = [[UINavigationController alloc] initWithRootViewController:[[TPProfileViewController alloc] init]];
        
        inboxViewController.title = @"Inbox";
        courseViewController.title = @"Courses";
        profileViewController.title = @"Profile";
        
        TPTabBarController *tabBarController = [[TPTabBarController alloc] init];
        
        tabBarController.viewControllers = @[inboxViewController, courseViewController, profileViewController];
        tabBarController.selectedIndex = 1;
        
        self.window.rootViewController = tabBarController;
    }
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
