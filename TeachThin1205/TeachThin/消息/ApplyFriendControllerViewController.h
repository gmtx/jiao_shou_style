//
//  ApplyFriendControllerViewController.h
//  TeachThin
//
//  Created by myStyle on 14-11-28.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HitView.h"

@interface ApplyFriendControllerViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, IChatManagerDelegate,HitViewDelegate>
{
    HitView            *hitView;
}
@property (nonatomic,assign) BOOL canCustomEdit;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *dataArray;

+ (instancetype)shareController;

- (void)addNewApply:(NSDictionary *)dictionary;

- (void)loadDataSourceFromLocalDB;

- (void)clear;
@end
