//
//  ShopViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14/11/12.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate>
{
    UICollectionView * collection;
}
@property(nonatomic,strong)UISearchBar * searchbar;
@end
