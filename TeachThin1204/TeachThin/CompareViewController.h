//
//  CompareViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompareViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NetViewDelegate>

{
    UITableView *table;
    UIView *headView;
    UIView *footerView;
    
    UIImageView *selfImgView ;
    UIImageView *TukuImgView;
}

@property NSInteger Foodtype;//菜品：0单品：1
@property(nonatomic,strong)UIImage *selfImg;
@property(nonatomic,retain)NSString *Foodname;

@property(nonatomic,retain)NSDictionary *DataDict;
@property NSInteger Listcount;
@property(nonatomic,retain)NSMutableArray *ListDataArr;
@property NSInteger page;
@end
