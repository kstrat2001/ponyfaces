//
//  AppDelegate.m
//  PonyFaces
//
//  Created by Kain Osterholt on 10/31/15.
//  Copyright © 2015 Kain. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"
#import "FileManager.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOption
{
    [[FileManager sharedManager] initDocRoot];
    
    UINavigationBar.appearance.tintColor = [UIColor purpleColor];
    UINavigationBar.appearance.barTintColor = ponyFacesPink;
    
    UITableView.appearance.backgroundColor = [UIColor purpleColor];
    UITableViewCell.appearance.backgroundColor = [UIColor purpleColor];
    UITableViewCell.appearance.tintColor = ponyFacesPink;
    
    UITabBar.appearance.barTintColor = ponyFacesPink;
    UITabBar.appearance.tintColor = [UIColor purpleColor];
    
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[UIViewController class]]] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor purpleColor],
       NSFontAttributeName:[UIFont fontWithName:@"Marker Felt" size:21]}];
    
    [[UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[UIViewController class]]] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor purpleColor],
       NSFontAttributeName:[UIFont fontWithName:@"Marker Felt" size:14]
       } forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor purpleColor],
       NSFontAttributeName:[UIFont fontWithName:@"Marker Felt" size:14]
       } forState:UIControlStateNormal];
    
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
    // Saves changes in the application's managed object context before the application terminates.
    [[DataManager sharedManager] saveContext];
}

@end
