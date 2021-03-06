//
//  AppDelegate.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "AppDelegate.h"
#import <SMS_SDK/SMS_SDK.h>
#import "LoginViewController.h"
#import "IntroduceViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSThread sleepForTimeInterval:1.5];
    [SMS_SDK registerApp:@"43ebece39bff " withSecret:@"ec29e1c8e7df7ee7c3d6c158ca7de26a"];
    [SMS_SDK enableAppContactFriends:NO];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBarTintColor:RGBACOLOR(88, 155, 34, 1)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
     [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:      [UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Helveyica-Bold" size:20.0], NSFontAttributeName,nil]];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"First"]) {
        IntroduceViewController * IntroduceVC = [[IntroduceViewController alloc]init];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        self.window.rootViewController = IntroduceVC;
    }else
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        UINavigationController * loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [loginNC setNavigationBarHidden:YES];
        self.window.rootViewController = loginNC;
    }
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"First"];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
