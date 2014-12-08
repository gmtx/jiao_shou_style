//
//  CompareViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface CompareViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NetViewDelegate>

{
    UITableView *table;
    UIView *headView;
    UIView *footerView;
    
    UIImageView *selfImgView ;
    UIImageView *TukuImgView;
    MJRefreshFooterView *freshFooter;
}

@property NSInteger Foodtype;//菜品：0单品：1
@property (nonatomic,strong)NSString *DanpinId;
@property(nonatomic,strong)UIImage *selfImg;
@property(nonatomic,retain)NSString *Foodname;

@property(nonatomic,retain)NSDictionary *DataDict;
@property NSInteger Listpage;
@property(nonatomic,retain)NSMutableArray *ListDataArr;

//@property(nonatomic,retain)NSArray *jiaohuanfenArr;
@end
