//
//  EaseMobProcessor.h
//  TeachThin
//
//  Created by myStyle on 14-11-26.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EaseMobProcessor : NSObject<IChatManagerDelegate>

+(void)    init:(UIApplication *)application
  launchOptions:(NSDictionary *)launchOptions;
+(void)registUser;
+(void) login:(BOOL)delay;
+(void) logout;


+ (void)registerRemoteNotification;
+(void)loginStateChange:(NSNotification *)notification;


+(NSInteger) unreadSupportMessageCount;
+(void) clearUnreadMessage:(EMConversation *)conversation;
+(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken;
+(void) registeDeviceToken:(UIApplication *)application deviceToken:(NSData *)deviceToken;

+(void) applicationWillResignActive:(UIApplication *)application;

+(void) applicationDidEnterBackground:(UIApplication *)application;

+(void) applicationWillEnterForeground:(UIApplication *)application;

+(void) applicationDidBecomeActive:(UIApplication *)application;

+(void) applicationWillTerminate:(UIApplication *)application;

+ (EaseMobProcessor *) sharedInstance;

@end
