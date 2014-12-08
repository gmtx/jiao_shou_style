//
//  ShopCell.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-14.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView * cellimg;
@property(nonatomic,strong)UILabel * titlelabel;
@property(nonatomic,strong)UILabel * oldprice;
@property(nonatomic,strong)UILabel * newprice;
@end
