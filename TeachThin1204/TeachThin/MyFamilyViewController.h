//
//  MyFamilyViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-14.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "familyCell.h"

@interface MyFamilyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,retain)UITableView *table;
@property (nonatomic,retain) NSMutableDictionary *dicClicked;
@property (nonatomic,retain)NSMutableArray *OpenCellArr;
@property NSInteger count;
@property CGFloat mHeight;
@property NSInteger sectionIndex;

@end
