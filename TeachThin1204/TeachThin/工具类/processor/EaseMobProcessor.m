//
//  EaseMobProcessor.m
//  TeachThin
//
//  Created by myStyle on 14-11-26.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "EaseMobProcessor.h"
#import "ApplyFriendControllerViewController.h"
@interface  EaseMobProcessor()

@property (nonatomic, strong) NSOperationQueue *queue;

@end
@implementation EaseMobProcessor
+(void) init:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions{
    //注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
//    NSString *apnsCertName = [AppStatus sharedInstance].easemobApnsCertName;
    //NSLog(@">>>>>>ease mob config: %@, %@", apnsCertName, [AppStatus sharedInstance].easemobAppKey);
#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"chatdemoui_dev";
#else
    apnsCertName = @"chatdemoui";
#endif
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"easemob-demo#chatdemoui" apnsCertName:apnsCertName];
    [[EaseMob sharedInstance] enableBackgroundReceiveMessage];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [[EaseMob sharedInstance].chatManager addDelegate:[EaseMobProcessor sharedInstance] delegateQueue:nil];
}

+(void) login:(BOOL)delay{
    double delayInSeconds = delay?0:2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[EaseMobProcessor sharedInstance] doLogin];
    });
}

-(void) doLogin{
    
    NSLog(@">>>>>>>>>>>>>登陆了！！！！");
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"lifestyle"
                                                        password:@"123456"
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         if (loginInfo && !error) {
             NSLog(@">>>>>>>>>>%@",loginInfo);
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
         }else {
            [EaseMobProcessor login:YES];
         }
     } onQueue:nil];
}

+(void) logout{
    AppStatus *as = [AppStatus sharedInstance];
    [[EaseMob sharedInstance].chatManager asyncLogoff];
    as.easeMobLogined = NO;
    [AppStatus saveAppStatus];
}


+ (void)registerRemoteNotification{
#if !TARGET_IPHONE_SIMULATOR
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
#endif
    
}

#pragma mark - private

+(void)loginStateChange:(NSNotification *)notification
{
    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
    BOOL loginSuccess = [notification.object boolValue];
    
    if (isAutoLogin || loginSuccess) {
        [[ApplyFriendControllerViewController shareController] loadDataSourceFromLocalDB];
    }
}

+(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

+(void) registeDeviceToken:(UIApplication *)application deviceToken:(NSData *)deviceToken{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

+(void) applicationWillResignActive:(UIApplication *)application{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

+(void) applicationDidEnterBackground:(UIApplication *)application{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

+(void) applicationWillEnterForeground:(UIApplication *)application{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

+(void) applicationDidBecomeActive:(UIApplication *)application{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
    [EaseMobProcessor login:NO];
}

+(void) applicationWillTerminate:(UIApplication *)application{
    // 让SDK得到App目前的各种状态，以便让SDK做出对应当前场景的操作
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

+ (EaseMobProcessor *) sharedInstance{
    static EaseMobProcessor *sharedInstance = nil;
    if(sharedInstance == nil){
        sharedInstance = [[EaseMobProcessor alloc] init];
        sharedInstance.queue = [[NSOperationQueue alloc]init];
    }
    
    return sharedInstance;
}
@end
