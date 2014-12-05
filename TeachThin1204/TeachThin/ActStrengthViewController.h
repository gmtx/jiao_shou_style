//
//  ActStrengthViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXSelectBtn.h"
@interface ActStrengthViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIBarButtonItem * sureBtn;
    UITableView * table;
    GXSelectBtn * selectBtn;
    UIImageView * selectimg;

}
@property(nonatomic,copy)NSString * actStrength;
@property(nonatomic,strong)NSArray * arr;
@property(nonatomic,strong)NSMutableArray * postArr;
@end
