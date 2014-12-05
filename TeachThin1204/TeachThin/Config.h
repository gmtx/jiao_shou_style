//
//  Config.h
//  FootballReservation
//
//  Created by 王园园 on 14-11-3.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject


+(NSString *)TimeToTimePr:(NSDate *)timeDate WithFormat:(NSString *)_fomatter;

+(NSString *)timePrToTime:(NSString *)timepr;
+(NSString *)getWeekdayWithNumber:(NSInteger)number;
@end
