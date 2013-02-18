//
//  AppDelegate.m
//  PayPalDemo
//
//  Created by Romeo Flauta on 2/15/13.
//  Copyright (c) 2013 CodeMagnus. All rights reserved.
//

#import "AppDelegate.h"
#import "PayPalVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [PayPal initializeWithAppID:@"APP-80W284485P519543T" forEnvironment:ENV_SANDBOX];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    PayPalVC *paypalVC = [[PayPalVC alloc] init];
   
    self.navController = [[UINavigationController alloc] initWithRootViewController:paypalVC];
    
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{

}



- (void)applicationWillEnterForeground:(UIApplication *)application
{

}



- (void)applicationDidBecomeActive:(UIApplication *)application
{

}



- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
