//
//  GXCalendar.h
//  rilidemo
//
//  Created by 巩鑫 on 14-11-25.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXCalendar : NSObject
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
- (NSDate *)nsDate;
@end
