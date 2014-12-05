//
//  SportsViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListMenuView.h"
#import <QuartzCore/QuartzCore.h>

@interface SportsViewController :UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    UIButton *homeBtn;
    ListMenuView *MenuView;
}
@property NSString *labelString;


@property(nonatomic,strong)NSArray *segDataArr;
@end
