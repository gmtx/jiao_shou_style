//
//  YiZhuViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-27.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegView.h"

@interface YiZhuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NetViewDelegate>
{
    UITableView *table;
    CustomSegView *segView;
}

@property(nonatomic,retain)NSString *planId;

@property(nonatomic,retain)NSDictionary *Datadict;
@property(nonatomic,retain)NSArray *titleKeyArr;
@property NSInteger segIndex;
@end
