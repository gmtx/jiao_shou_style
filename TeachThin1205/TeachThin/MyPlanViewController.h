//
//  MyPlanViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPlanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,NetViewDelegate>
{
    UITableView * table;
    UIView * header;
    UIView * footer;
    UILabel * label;
    UIButton * sureBtn;
    UITextField * tf1,*tf2,*tf3,*tf4,*tf5,*tf6;
}
@property(nonatomic,copy)NSString * datetime;
@property(nonatomic,strong)NSArray * arr;
@property(nonatomic,strong)UILabel * celltitle;

@end
