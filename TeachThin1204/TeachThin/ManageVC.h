//
//  ManageVC.h
//  TeachThin
//
//  Created by 巩鑫 on 14/11/12.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageVC : NSObject
@property BOOL LoginState;
@property(nonatomic,copy)NSString * userSex;


+(ManageVC *)sharedManage;
+(NSString *)TimeToTimePr:(NSDate *)timeDate WithFormat:(NSString *)_fomatter;
+(NSString *)timePrToTime:(NSString *)timepr;

+(NSString *)DateStrFromDate:(NSDate *)date Withformat:(NSString *)str;
+(NSString *)getWeekday:(NSDate *)date;

@end
