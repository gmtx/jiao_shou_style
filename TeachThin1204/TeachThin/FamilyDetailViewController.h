//
//  FamilyDetailViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-24.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Datetime.h"

@interface FamilyDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    UITableViewCell *Calendercell;
}
@property(strong, nonatomic)UIView *titleView;
@end
