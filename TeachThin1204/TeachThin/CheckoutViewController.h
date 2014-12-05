//
//  CheckoutViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXSelectBtn.h"
@interface CheckoutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * table;
    UIView * footer;
    UIButton * sureBtn;
    UILabel * Allprice;
    GXSelectBtn * selectBtn;
}
@property(nonatomic,strong)NSArray * Arr;
@property(nonatomic,strong)NSMutableArray * postArr;

@end
