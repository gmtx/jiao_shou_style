//
//  CustomSegView.m
//  FootballReservation
//
//  Created by 王园园 on 14-10-31.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import "CustomSegView.h"
#define WEIGHT 80.
#define MARGIN 1.
#define SLiderWeight 70.
#define SLiderHeight 1.5
@implementation CustomSegView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.bounces = NO;
        self.userInteractionEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        //self.contentOffset = CGPointMake(0, -40);
    
        UIImageView *longLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height-1., frame.size.width, 0.5)];
        longLine.backgroundColor = RGBACOLOR(181., 181., 181., 1) ;
        [self addSubview:longLine];
        
        
        _sliderView = [[UIView alloc]initWithFrame:CGRectMake((WEIGHT-SLiderWeight)/2, frame.size.height-SLiderHeight, SLiderWeight, SLiderHeight)];
        _sliderView.backgroundColor = RGBACOLOR(75., 148., 9., 1);
        [self addSubview:_sliderView];
    }
    return self;
}

-(void)setTitleArr:(NSArray *)titles;
{
    for(int i=0;i<titles.count;i++){
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake((WEIGHT+MARGIN)*i, 0, WEIGHT, self.frame.size.height);
        [btn1 setTitle:titles[i] forState:UIControlStateNormal];
        btn1.tag = i;
        [btn1 setTitleColor:RGBACOLOR(181., 181., 181., 1) forState:UIControlStateNormal];
        [btn1 setTitleColor:RGBACOLOR(75., 148., 9., 1) forState:UIControlStateSelected];
        [btn1 addTarget:self action:@selector(BtnTap:) forControlEvents:UIControlEventTouchUpInside];
        btn1.titleLabel.font = [UIFont systemFontOfSize:14.5];
        [self addSubview:btn1];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(WEIGHT*i, self.frame.size.height/2-8, MARGIN, 16)];
        lable.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lable];
        //设置默认选中第0个
        if(i==0){
            btn1.selected = YES;
            tempBtn = btn1;
        }
    }
    [self setContentSize:CGSizeMake((WEIGHT+MARGIN)*titles.count, 1)];
    self.contentOffset = CGPointMake(0, 70);
}

-(void)BtnTap:(UIButton *)btn
{
    if(btn == tempBtn){
        ;
    }else{
        tempBtn.selected = NO;
        btn.selected = YES;
        tempBtn=btn;
        
        [UIView animateWithDuration:0.1 animations:^{
            _sliderView.frame = CGRectMake(btn.frame.origin.x+(WEIGHT-SLiderWeight)/2, self.frame.size.height-SLiderHeight, SLiderWeight, SLiderHeight);
        } completion:^(BOOL finished) {
            if(_SegBtntap){
                _SegBtntap(btn.tag);
            }
        }];
    }
}



@end
