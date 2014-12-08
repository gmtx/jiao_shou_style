//
//  CollectionViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NetViewDelegate>
{
    UITableView *table;
    UILabel *infoLable;
}

@property(nonatomic,retain)NSString *uid;
@property(nonatomic,strong)NSMutableArray *ListArr;
@end
