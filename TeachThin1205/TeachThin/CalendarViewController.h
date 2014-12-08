//
//  CalendarViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-26.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController<NetViewDelegate>
{
    UIBarButtonItem * right;
    UIView * headerView;
    UILabel * lable1;
    UILabel * label2;
    UIView * footer;
    
}
@property(nonatomic,copy)NSString * noDataDay;
@property(nonatomic,copy)NSString * day;
@property(nonatomic,copy)NSString * FillDate;
@end
