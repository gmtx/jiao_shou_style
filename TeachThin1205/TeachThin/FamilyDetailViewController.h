//
//  FamilyDetailViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-24.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Datetime.h"

@interface FamilyDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NetViewDelegate>
{
    UITableView *table;
    UITableViewCell *Calendercell;
    UILabel *InfoLable;//底部label
    
    UIImageView *userimgView;
    UILabel *titleLable;
    UILabel *phoneLable;
}
//////
@property(nonatomic,retain)NSString *uid;
@property(nonatomic,retain)NSString *userName;
@property(nonatomic,retain)NSString *telephone;
@property(nonatomic,retain)NSString *userImg;
/////
@property(strong, nonatomic)UIView *titleView;

@property(nonatomic,retain)NSDictionary *DataDict;
@property(nonatomic,retain)NSArray *StatusArr;
@property long long startDate;
@property long long endDate;
@end
