//
//  AppDelegate.m
//  Hypnosister
//
//  Created by Omri Meshulam on 2/17/15.
//  Copyright (c) 2015 OmriMeshulam. All rights reserved.
//

#import "OGMAppDelegate.h"
#import "OGMHypnosisView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch
    
    // Creating CGRects for frames
    CGRect screenRect = self.window.bounds;
    CGRect bigrRect = screenRect;
    bigrRect.size.width *= 2.0;
    
    // Creating a screen-sized scroll view and adding it to the window
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    scrollView.pagingEnabled = YES;
    [self.window addSubview:scrollView];
    
    // Creating a screen-sized hypnosis view adding it to the scroll view
    OGMHypnosisView *hypnosisView = [[OGMHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:hypnosisView];
    
    // Adding a second screen-sized hypnosis view just off the screen to the right
    screenRect.origin.x += screenRect.size.width;
    OGMHypnosisView *anotherView = [[OGMHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:anotherView];
    
    // Telling the scroll view how big its content area is
    scrollView.contentSize = bigrRect.size;
    
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
