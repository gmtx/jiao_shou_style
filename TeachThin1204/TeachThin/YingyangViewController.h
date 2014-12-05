//
//  YingyangViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-24.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "yingyangCell.h"
#import "ListMenuView.h"

@interface YingyangViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
{
    UICollectionView *collection;
    ListMenuView *MenuView;

    UISearchBar *searchBar;
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
}




@end
