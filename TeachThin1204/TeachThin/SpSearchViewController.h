//
//  SpSearchViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpSearchViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar *mySearchBar;
    UITableView *tableView;
    UIView *_viewBlackCover;
}

- (void)setRecentKeyword:(NSArray *)arrRecentKeyword;
- (void)setKeyword:(NSString *)strKeyword;
@property BOOL bIsWorking ;
@property (nonatomic, readonly) NSArray *arrRecent;
@end
