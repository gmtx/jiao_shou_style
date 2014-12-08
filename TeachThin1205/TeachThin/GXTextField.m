//
//  GXTextField.m
//  FootballReservation
//
//  Created by 巩鑫 on 14-10-13.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import "GXTextField.h"

@implementation GXTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)drawPlaceholderInRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1].CGColor);
    
    CGRect inset = CGRectMake(self.bounds.origin.x+30, self.bounds.origin.y+10, self.bounds.size.width , self.bounds.size.height);
    [self.placeholder drawInRect:inset withFont:[UIFont boldSystemFontOfSize:16.]];
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
