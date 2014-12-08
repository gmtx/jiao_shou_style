//
//  FriendDetailView.m
//  TeachThin
//
//  Created by myStyle on 14-11-27.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "FriendDetailView.h"

@implementation FriendDetailView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        self.userImageView.backgroundColor = [UIColor clearColor];
        self.userImageView.image = [UIImage imageNamed:@"chatListCellHead.png"];
        CALayer *layer = self.userImageView.layer;
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:self.userImageView.frame.size.width/2];
        [layer setBorderWidth:2.0f];
        [layer setBorderColor:[UIColor whiteColor].CGColor];
        [self addSubview:self.userImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 150, 25 )];
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.nameLabel];
        
        self.sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 150, 25 )];
        self.sexLabel.text = @"性别：男";
        self.sexLabel.textColor = [UIColor grayColor];
        self.sexLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.sexLabel];
        
        self.ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 55, 150, 25 )];
        self.ageLabel.text = @"年龄：18";
        self.ageLabel.textColor = [UIColor grayColor];
        self.ageLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.ageLabel];
        
        self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, 150, 25 )];
        self.phoneLabel.text = @"手机号：1234567890";
        self.phoneLabel.textColor = [UIColor grayColor];
        self.phoneLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.phoneLabel];
        
        
    }
    return self;
}

-(void)renderUser:(NSMutableArray *)array{
    self.nameLabel.text = [array objectAtIndex:0];
}


@end
