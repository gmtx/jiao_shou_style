//
//  AppStatus.h
//  styler
//
//  Created by System Administrator on 13-5-13.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "User.h"
#import <Foundation/Foundation.h>

@interface AppStatus : NSObject<NSCoding>

@property (nonatomic, retain) NSString *currentLocation;
@property (nonatomic, retain) NSString *deviceToken;
@property double lastLat;//纬度
@property double lastLng;//经度
@property (nonatomic, retain)User *user;
@property (nonatomic, retain)NSString *easemobApnsCertName;
@property (nonatomic, retain)NSString *easemobAppKey;
@property BOOL easeMobLogined;

-(float) iosVersion;
-(NSString *) appVersion;
-(BOOL) logined;
+(void) saveAppStatus;
+ (AppStatus *) sharedInstance;
+ (NSString *) savedPath;

-(NSString *) ua;

@end
