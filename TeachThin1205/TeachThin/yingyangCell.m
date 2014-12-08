//
//  yingyangCell.m
//  TeachThin
//
//  Created by 王园园 on 14-11-24.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "yingyangCell.h"

@implementation yingyangCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _Img  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 85, 120)];
        _Img.backgroundColor = GXRandomColor;
        [self.contentView addSubview:_Img];
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
