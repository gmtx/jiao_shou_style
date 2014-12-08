//
//  SexViewController.h
//  FootballReservation
//
//  Created by 巩鑫 on 14-10-21.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    UIBarButtonItem * right;
    UITableView * table;

}
@property(nonatomic,copy)NSString * sex;
@property NSInteger pushFlag;
@end
