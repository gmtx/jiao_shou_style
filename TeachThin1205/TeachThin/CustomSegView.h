//
//  CustomSegView.h
//  FootballReservation
//
//  Created by 王园园 on 14-10-31.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSegView : UIScrollView
{
    UIButton *tempBtn;
}

@property (nonatomic,strong)UIView *sliderView;
@property(nonatomic,strong) void (^SegBtntap)(NSInteger);


-(void)setTitleArr:(NSArray *)titles;




@end
