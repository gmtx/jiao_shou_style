//
//  ListMenuView.h
//  Lianxi
//
//  Created by 王园园 on 14-8-27.
//  Copyright (c) 2014年 王园园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListMenuView : UIView<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView *ListTable;
@property(nonatomic,retain)UIImageView *MenuImage;


@property(nonatomic,retain)NSArray *ListArr;
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger cellIndex);
-(void)setListDataArr:(NSArray *)arr;
@end
