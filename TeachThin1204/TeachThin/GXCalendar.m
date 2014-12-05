//
//  GXCalendar.m
//  rilidemo
//
//  Created by 巩鑫 on 14-11-25.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "GXCalendar.h"

@implementation GXCalendar
@synthesize day,year,month;

- (NSDate *)nsDate
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = self.year;
    components.month = self.month;
    components.day = self.day;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

@end
