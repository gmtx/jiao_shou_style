//
//  RecipesViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14/11/12.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomActionSheet.h"
@interface RecipesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NetViewDelegate>
{
    UILabel * label1;
    UIButton * dateBtn;
    UITableView * table;
    UIView * header;
    UIView * footer;
    UIButton * planBtn;
    UIButton * noplanBtn;
}

@property(nonatomic,strong)CustomActionSheet * cas;
@property (nonatomic,strong)UIDatePicker * dp;
@property(nonatomic,assign)NSDate * Showdate;
@property(nonatomic,copy)NSString * datetime;
@property(nonatomic,copy)NSString * weektime;
@property(nonatomic,copy)NSString * datetime1;
@property(nonatomic,copy)NSString * weektime1;


@property(nonatomic,strong)NSDictionary * dict;
@property(nonatomic,strong)NSArray * arr;
@property(nonatomic,strong)UILabel * celltitle;
@property(nonatomic,strong)UILabel * cellcontent;

@end
