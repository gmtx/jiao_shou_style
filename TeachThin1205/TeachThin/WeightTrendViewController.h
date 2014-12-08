//
//  WeightTrendViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-24.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomActionSheet.h"
@interface WeightTrendViewController : UIViewController<NetViewDelegate>
{
    UIView * header;
    UILabel * label;
    UIButton * startBtn;
    UIView * footer;
    UILabel * label1;
    UIButton * homeBtn;
    UIButton * dateBtn;
    
}
@property(nonatomic,copy)NSString * startDate;
@property(nonatomic,copy)NSString * datetime;
@property(nonatomic,copy)NSString * weektime;
@property(nonatomic,strong)CustomActionSheet * cas;
@property (nonatomic,strong)UIDatePicker * dp;


@end
