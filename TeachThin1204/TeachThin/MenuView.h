//
//  MenuView.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-26.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * table;

}
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger cellIndex);

@end
