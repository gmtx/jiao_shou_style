//
//  ManageVC.m
//  TeachThin
//
//  Created by 巩鑫 on 14/11/12.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import "ManageVC.h"
static ManageVC * manage;
@implementation ManageVC

+(ManageVC*)sharedManage
{
    if (manage==nil) {
         manage = [[ManageVC alloc] init];
        manage.LoginState = [[NSUserDefaults standardUserDefaults]boolForKey:@"loginState"];
    }
    return manage;
}



-(BOOL)setisLogin:(BOOL)state
{
    _LoginState = state;
    return _LoginState;
}



//timeStr->timePr
+(NSString *)TimeToTimePr:(NSDate *)timeDate WithFormat:(NSString *)_fomatter;
{
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init] ;
    [dateday setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"]];
    [dateday setDateFormat:_fomatter];
    //转化时间戳
    NSString *timePr = [NSString stringWithFormat:@"%ld", (long)[timeDate timeIntervalSince1970]];
    return timePr;
}

//timepr->timeStr
+(NSString *)timePrToTime:(NSString *)timepr;
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timepr longLongValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //////////////////////
    NSString *time = [formatter stringFromDate:date];
    return time;
}


+(NSString *)getWeekday:(NSDate *)date
{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
    NSString *weekday = [self getWeekdayWithNumber:[componets weekday]];
    return weekday;
}

//Date->string
+(NSString *)DateStrFromDate:(NSDate *)date Withformat:(NSString *)str
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:str];
    NSString * dateString = [dateFormat stringFromDate:date];
    return dateString;
}
//1代表星期日、如此类推
+(NSString *)getWeekdayWithNumber:(int)number
{
    switch (number) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            return @"";
            break;
    }
}

@end
