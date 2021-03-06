//
//  AppDelegate.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "AppDelegate.h"
#import "EMDataService.h"
#import "EMAirport.h"
#import "UIColor+ColorWithHexAndAlpha.h"
#import "EMFeedback.h"

#define KEY_PARSE_APPLICATION_ID_DESENV @"KEnFNcnLArxlllOus00LNLjM6KosLi11tTJn7Aes"
#define KEY_PARSE_CLIENT_KEY_DESENV     @"ZefV9QEgxnAnsHS8im6sg0R49evcyYOKVTWWsFDb"
#define KEY_GOOGLE_ANALYTICS @"UA-61802899-1"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crashlytics startWithAPIKey:@"4e076605a89bca6719313424e40c17037f78bc19"];
    
    [EMAirport registerSubclass];
    [EMFeedback registerSubclass];
    
    [Parse setApplicationId:KEY_PARSE_APPLICATION_ID_DESENV
                  clientKey:KEY_PARSE_CLIENT_KEY_DESENV];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //GOOGLE ANALYTICS
    [MXGoogleAnalytics ga_inicializeWithTrackingId:KEY_GOOGLE_ANALYTICS];
    [MXGoogleAnalytics ga_trackApplicationLauchingWithOptions:launchOptions];
    
    [self setAppearanceToElements];
    
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

- (void)setAppearanceToElements
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //61C2DB - Original
    //469CB5 - Original Darker
    UIColor *baseColor = [UIColor colorWithHex:@"469CB5" andAlpha:1.0];
    
    // Changes appearance of NavigationController
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearance] setBarTintColor:baseColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    //[[UITabBar appearance] setBarTintColor:baseColor];
    //[[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:baseColor];
}

@end
