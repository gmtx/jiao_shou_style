//
//  GXSelectBtn.m
//  FootballReservation
//
//  Created by 巩鑫 on 14/10/31.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import "GXSelectBtn.h"

@implementation GXSelectBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.Btnimg = [[UIImageView alloc]initWithFrame:CGRectMake(280, 13, 18, 18)];
        self.Btnimg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"langou"]];
        [self addSubview:self.Btnimg];
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
