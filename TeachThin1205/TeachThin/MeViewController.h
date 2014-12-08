//
//  MeViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14/11/12.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
  
    //表格视图
    UITableView * table;
    //头视图
    UIView * header;
    //头像区域图片视图
    UIButton * backBtn;
    UIButton * setBtn;
    UIImageView * headimg;
    UILabel * line;
    UIView * footer;
    //昵称
    UILabel * label;
    
    UIImageView * cellimg;
    UILabel * celltitle;
    
    UIButton * collectBtn;
    UIButton * messageBtn;

}
@end
