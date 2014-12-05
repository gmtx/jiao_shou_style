//
//  ShopCell.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-14.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "ShopCell.h"

@implementation ShopCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _cellimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
        [self addSubview:_cellimg];
        
        _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, VIEW_MAXY(_cellimg), 50, 20)];
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        _titlelabel.font =[UIFont systemFontOfSize:16.0];
        _titlelabel.textColor = [UIColor blackColor];
        [self addSubview:_titlelabel];
        
  
        
        _oldprice = [[UILabel alloc]initWithFrame:CGRectMake(0, VIEW_MAXY(_titlelabel), 90, 20)];
        _oldprice.textColor = [UIColor grayColor];
        _oldprice.font = [UIFont systemFontOfSize:12.0];
        _oldprice.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_oldprice];
        
        _newprice = [[UILabel alloc]initWithFrame:CGRectMake(0, VIEW_MAXY(_oldprice), 90, 20)];
        _newprice.textAlignment = NSTextAlignmentLeft;
        _newprice.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_newprice];
        
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
