//
//  ChufangViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-28.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChufangViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
}

@property(nonatomic,retain)NSString *jieduanId;//上页面传值过来
@property(nonatomic,retain)NSDictionary *DataDict;

@end
