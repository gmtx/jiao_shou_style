//
//  EaseMobProcessor.m
//  TeachThin
//
//  Created by myStyle on 14-11-26.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "EaseMobProcessor.h"
#import "ApplyFriendControllerViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ManageVC.h"
@interface  EaseMobProcessor()

@property (nonatomic, strong) NSOperationQueue *queue;

@end
@implementation EaseMobProcessor
+(void) init:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions{
    
[[NSNotificationCenter defaultCenter] addObserver:[EaseMobProcessor sharedInstance]
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];

#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
//    NSString *apnsCertName = nil;
//#if DEBUG
//    apnsCertName = @"jiaoshou";
//#else
//    apnsCertName = @"jiaoshou";
//#endif
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"chatdemoui_dev";
#else
    apnsCertName = @"chatdemoui";
#endif
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"easemob-demo#chatdemoui" apnsCertName:apnsCertName];
    
#if DEBUG
    [[EaseMob sharedInstance] enableUncaughtExceptionHandler];
#endif
    [[[EaseMob sharedInstance] chatManager] setAutoFetchBuddyList:YES];
    
    //以下一行代码的方法里实现了自动登录，异步登录，需要监听[didLoginWithInfo: error:]
    //demo中此监听方法在MainViewController中
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
#warning 注册为SDK的ChatManager的delegate (及时监听到申请和通知)
    [[EaseMob sharedInstance].chatManager removeDelegate:[EaseMobProcessor sharedInstance]];
    [[EaseMob sharedInstance].chatManager addDelegate:[EaseMobProcessor sharedInstance] delegateQueue:nil];
    
#warning 如果使用MagicalRecord, 要加上这句初始化MagicalRecord
    //demo coredata, .pch中有相关头文件引用
    [MagicalRecord setupCoreDataStackWithStoreNamed:[NSString stringWithFormat:@"%@.sqlite", @"UIDemo"]];
    
//    [[EaseMobProcessor sharedInstance] loginStateChange:nil];
    NSLog(@">>>>>>>>>>>>>>>>>>>>init ease mob");

}

+(void) login:(BOOL)delay WithUserName:(NSString *)userName pwd:(NSString *)pwd{
    double delayInSeconds = delay?0:2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[EaseMobProcessor sharedInstance] doLoginWithUserName:userName pwd:pwd];
    });
}

-(void) doLoginWithUserName:(NSString *)userName pwd:(NSString *)pwd{
    
    NSLog(@">>>>>>>>>>>>>登陆了！！！！");
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userName
                                                        password:pwd
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
//         if (loginInfo && !error) {
//             NSLog(@">>>>>>>>>>%@",loginInfo);
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
//         }else {
//            [EaseMobProcessor login:YES WithUserName:userName pwd:pwd];
//             [AppStatus saveAppStatus];
//         }
         if (loginInfo && !error) {
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
         }else {
             switch (error.errorCode) {
                 case EMErrorServerNotReachable:
                     TTAlertNoTitle(@"连接服务器失败!");
                     break;
                 case EMErrorServerAuthenticationFailure:
                     TTAlertNoTitle(@"用户名或密码错误");
                     break;
                 case EMErrorServerTimeout:
                     TTAlertNoTitle(@"连接服务器超时!");
                     break;
                 default:
                     TTAlertNoTitle(@"登录失败");
                     break;
             }
         }

     } onQueue:nil];
}

+(void)registUserWithUserName:(NSString *)userName pwd:(NSString *)pwd{
    [EaseMobProcessor sharedInstance].userName = userName;
    [EaseMobProcessor sharedInstance].pwd = pwd;
    NSLog(@">>>>>>>>>>>>%@, %@",[EaseMobProcessor sharedInstance].userName,[EaseMobProcessor sharedInstance].pwd);
    
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:userName
                                                         password:pwd
                                                   withCompletion:
     ^(NSString *username, NSString *password, EMError *error) {
         if (!error) {
             TTAlertNoTitle(@"注册成功,请登录");
             [EaseMobProcessor login:NO WithUserName:userName pwd:pwd];
         }else{
             switch (error.errorCode) {
                 case EMErrorServerNotReachable:
                     TTAlertNoTitle(@"连接服务器失败!");
                     break;
                 case EMErrorServerDuplicatedAccount:
                     TTAlertNoTitle(@"您注册的用户已存在!");
                     [EaseMobProcessor login:NO WithUserName:userName pwd:pwd];
                     break;
                 case EMErrorServerTimeout:
                     TTAlertNoTitle(@"连接服务器超时!");
                     break;
                 default:
                     TTAlertNoTitle(@"注册失败");
                     break;
             }
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

-(void)loginStateChange:(NSNotification *)notification
{
    
    NSLog(@">>>>>>>>>>>>>>>>登录状态改变！！！！！");
    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
    BOOL loginSuccess = [notification.object boolValue];
    
    if (isAutoLogin || loginSuccess) {
        [[ApplyFriendControllerViewController shareController] loadDataSourceFromLocalDB];
//        if ([EaseMobProcessor sharedInstance].homeVC == nil) {
//            [EaseMobProcessor sharedInstance].homeVC = [[HomePageViewController alloc] init];
//            nav = [[UINavigationController alloc] initWithRootViewController:[EaseMobProcessor sharedInstance].homeVC];
//        }else{
//            nav  = [EaseMobProcessor sharedInstance].homeVC.navigationController;
//        }
    }else{
//        [EaseMobProcessor sharedInstance].homeVC = nil;
//        LoginViewController *loginController = [[LoginViewController alloc] init];
//        nav = [[UINavigationController alloc] initWithRootViewController:loginController];
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
    NSLog(@">>>>>>>applicationDidBecomeActive>>>>>>>>>>>");
    if ([ManageVC sharedManage].LoginState == YES) {
         [EaseMobProcessor login:NO WithUserName:[EaseMobProcessor sharedInstance].userName pwd:[EaseMobProcessor sharedInstance].pwd];
    }
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
