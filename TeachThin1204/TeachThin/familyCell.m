//
//  familyCell.m
//  TeachThin
//
//  Created by 王园园 on 14-11-21.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "familyCell.h"

@implementation familyCell

- (void)awakeFromNib
{
    // Initialization code
    _userImg.layer.cornerRadius = 25.;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtnPress:)];
    _View1.tag=0;
    [_View1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtnPress:)];
    _View2.tag=1;
    [_View2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtnPress:)];
    _View3.tag = 2;
    [_View3 addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtnPress:)];
    _View4.tag = 3;
    [_View4 addGestureRecognizer:tap4];
}

-(void)BtnPress:(UITapGestureRecognizer *)gesture
{
    if(_BtntapMethed){
        self.BtntapMethed(gesture.view.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
