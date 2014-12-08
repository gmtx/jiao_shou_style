//
//  JDplanViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-28.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Datetime.h"

@interface JDplanViewController : UIViewController<NetViewDelegate>
{
    UIView *header;
}

@property(nonatomic,retain)UIView *CalenderView;

@property(nonatomic,retain)NSString *jieduanId;//上页面传值过来
@property(nonatomic,retain)NSDictionary *DataDict;
@property(nonatomic,retain)NSArray *StatusArr;

@property long long startDate;
@property long long endDate;
@end
