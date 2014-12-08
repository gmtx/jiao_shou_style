//
//  PhotoMoreViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-26.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoMoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *table;
}

@property(nonatomic,retain)NSDictionary *Datadict;
@property (nonatomic,retain)NSArray *DataArr;
@property(nonatomic,retain)NSArray *titleArr;
@property(nonatomic,retain)NSArray *keyArr;

@end
