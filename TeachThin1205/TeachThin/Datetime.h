//
//  Datetime.h
//  rilidemo
//
//  Created by 巩鑫 on 14-11-25.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Datetime : NSObject
//所有年列表
+(NSArray *)GetAllYearArray;

//所有月列表
+(NSArray *)GetAllMonthArray;



//获取指定年份指定月份的星期排列表
+(NSArray *)GetDayArrayByYear:(int) year
                     andMonth:(int) month;

//获取指定年份指定月份的星期排列表(农历)
+(NSArray *)GetLunarDayArrayByYear:(int) year
                          andMonth:(int) month;

//获取某年某月某日的对应农历
+(NSString *)GetLunarDayByYear:(int) year
                      andMonth:(int) month
                        andDay:(int) day;


//以YYYY.MM.dd格式输出年月日
+(NSString*)getDateTime;

//以YYYY年MM月dd日格式输出年月日
+(NSString*)GetDateTime;

//以YYYY年MMdd格式输出此时的农历年月日
+(NSString*)GetLunarDateTime;

+(NSString *)GetYear:(NSDate *)Date;

+(NSString *)GetMonth:(NSDate *)Date;

+(NSString *)GetDay:(NSDate *)Date;

+(NSString *)GetHour;

+(NSString *)GetMinute;

+(NSString *)GetSecond;
@end
