//
//  ShopDetailViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-14.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
 
    UITableView * table;
    
    UIView * footer;
    UIButton * sureBtn;
}
@end
