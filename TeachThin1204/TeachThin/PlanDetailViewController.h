//
//  PlanDetailViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-21.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NetViewDelegate>
{
    UITableView *table;
}
@property(nonatomic,retain)NSString *planId;//上页面传值过来
@property(nonatomic,retain)NSDictionary *DataDict;
@property(nonatomic,retain)NSArray *jieduanArr;

@end
