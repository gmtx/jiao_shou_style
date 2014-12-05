/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "ApplyFriendCell.h"

#define AGREE_BUTTON_WIDHT 80
#define UNAGREE_BUTTON_WIDTH   80
#define IGNORE_BUTTON_WIDTH 80
#define BOUNENCE            0
@implementation ApplyFriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
//        _headerImageView.backgroundColor = [UIColor clearColor];
//        _headerImageView.clipsToBounds = YES;
//        _headerImageView.layer.cornerRadius = 5.0;
//        [self.contentView addSubview:_headerImageView];
//        
//        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.backgroundColor = [UIColor clearColor];
//        _titleLabel.textColor = [UIColor blackColor];
//        _titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
//        [self.contentView addSubview:_titleLabel];
//        
//        _contentLabel = [[UILabel alloc] init];
//        _contentLabel.numberOfLines = 0;
//        _contentLabel.backgroundColor = [UIColor clearColor];
//        _contentLabel.textColor = [UIColor grayColor];
//        _contentLabel.font = [UIFont systemFontOfSize:14.0];
//        [self.contentView addSubview:_contentLabel];
//        
//        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0, 50, 30)];
//        [_addButton setBackgroundColor:[UIColor colorWithRed:10 / 255.0 green:82 / 255.0 blue:104 / 255.0 alpha:1.0]];
//        [_addButton setTitle:@"接受" forState:UIControlStateNormal];
//        _addButton.clipsToBounds = YES;
//        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _addButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        [_addButton addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_addButton];
//        
//        _refuseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 120, 0, 50, 30)];
//        [_refuseButton setBackgroundColor:[UIColor colorWithRed:87 / 255.0 green:186 / 255.0 blue:205 / 255.0 alpha:1.0]];
//        [_refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
//        _refuseButton.clipsToBounds = YES;
//        [_refuseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _refuseButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        [_refuseButton addTarget:self action:@selector(refuseFriend) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_refuseButton];
//        
//        _bottomLineView = [[UIView alloc] init];
//        _bottomLineView.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
//        [self.contentView addSubview:_bottomLineView];
        
        if (_moveContentView == nil) {
            _moveContentView = [[UIView alloc] init];
            _moveContentView.backgroundColor = [UIColor whiteColor];
        }
        [self.contentView addSubview:_moveContentView];
        
        NSLog(@">>>>>>self.frame.size.height>>>>>>>>>%f",self.frame.size.height);
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(70, 60-0.5, VIEW_WEIGHT-70, 0.5)];
        self.lineView.backgroundColor = RGBACOLOR(207, 210, 213, 0.7);
        [self.contentView addSubview:self.lineView];
        
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self addControl];
        [self addSubviewInMoveContentView];

        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self addControl];
    [self addSubviewInMoveContentView];
}

-(void)addSubviewInMoveContentView{
    self.userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
    self.userImageView.backgroundColor = [UIColor clearColor];
    self.userImageView.image = [UIImage imageNamed:@"chatListCellHead.png"];
    CALayer *layer = self.userImageView.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:self.userImageView.frame.size.width/2];
    [self.moveContentView addSubview:self.userImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 150, 25 )];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.text = @"新朋友";
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self.moveContentView addSubview:self.nameLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 250, 25 )];
    self.contentLabel.text = @"天天请求加你为好友。";
    self.contentLabel.textColor = [UIColor grayColor];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    [self.moveContentView addSubview:self.contentLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 5, 90, 25 )];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.text = @"13:00";
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    [self.moveContentView addSubview:self.timeLabel];
    
    self.notifLabel = [[UILabel alloc] initWithFrame:CGRectMake(285, 30, 25, 25 )];
    self.notifLabel.text = @"1";
    self.notifLabel.backgroundColor = [UIColor redColor];
    layer = self.notifLabel.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:self.notifLabel.frame.size.width/2];
    self.notifLabel.textAlignment = NSTextAlignmentCenter;
    self.notifLabel.textColor = [UIColor whiteColor];
    self.notifLabel.font = [UIFont systemFontOfSize:14];
    [self.moveContentView addSubview:self.notifLabel];
}

-(void)addControl{
    UIView *menuContetnView = [[UIView alloc] init];
    menuContetnView.hidden = YES;
    menuContetnView.tag = 100;
    
    UIButton *vDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [vDeleteButton setBackgroundColor:RGBACOLOR(46, 199, 88, 1)];
    [vDeleteButton setTitle:@"同意" forState:UIControlStateNormal];
    [vDeleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [vDeleteButton addTarget:self action:@selector(agreeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [vDeleteButton setTag:1001];
    
    UIButton *vMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [vMoreButton setBackgroundColor:RGBACOLOR(230, 231, 232, 1)];
    [vMoreButton setTitle:@"不同意" forState:UIControlStateNormal];
    [vMoreButton setTitleColor:RGBACOLOR(17, 153, 203, 1) forState:UIControlStateNormal];
    [vMoreButton addTarget:self action:@selector(unAgreeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [vMoreButton setTag:1002];
    
    UIButton *vIgnoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [vIgnoreButton setBackgroundColor:RGBACOLOR(220, 221, 222, 1)];
    [vIgnoreButton setTitle:@"忽略" forState:UIControlStateNormal];
    [vIgnoreButton setTitleColor:RGBACOLOR(87, 169, 0, 1) forState:UIControlStateNormal];
    [vIgnoreButton addTarget:self action:@selector(ignoreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [vIgnoreButton setTag:1003];
    
    
    [menuContetnView addSubview:vDeleteButton];
    [menuContetnView addSubview:vMoreButton];
    [menuContetnView addSubview:vIgnoreButton];
    
    [self.contentView insertSubview:menuContetnView atIndex:0];
    
    UIPanGestureRecognizer *vPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    vPanGesture.delegate = self;
    [self.contentView addGestureRecognizer:vPanGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.delegate = self;
    [self.contentView addGestureRecognizer:tapGesture];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"layoutSubviews:_moveContentView:%@",NSStringFromCGRect(self.contentView.frame));
    [_moveContentView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UIView *vMenuView = [self.contentView viewWithTag:100];
    vMenuView.frame =CGRectMake(self.frame.size.width - AGREE_BUTTON_WIDHT - UNAGREE_BUTTON_WIDTH - IGNORE_BUTTON_WIDTH, 0, AGREE_BUTTON_WIDHT + UNAGREE_BUTTON_WIDTH + IGNORE_BUTTON_WIDTH, self.frame.size.height);
    UIView *vDeleteButton = [self.contentView viewWithTag:1001];
    vDeleteButton.frame = CGRectMake(UNAGREE_BUTTON_WIDTH+IGNORE_BUTTON_WIDTH, 0, AGREE_BUTTON_WIDHT, self.frame.size.height);
    UIView *vMoreButton = [self.contentView viewWithTag:1002];
    vMoreButton.frame = CGRectMake(IGNORE_BUTTON_WIDTH, 0, UNAGREE_BUTTON_WIDTH, self.frame.size.height);
    
    UIView *vIgnoreButton = [self.contentView viewWithTag:1003];
    vIgnoreButton.frame = CGRectMake(0, 0, IGNORE_BUTTON_WIDTH, self.frame.size.height);

}

//此方法和下面的方法很重要,对ios 5SDK 设置不被Helighted
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    // Configure the view for the selected state
    UIView *vMenuView = [self.contentView viewWithTag:100];
    if (vMenuView.hidden == YES) {
        [super setSelected:selected animated:animated];
        self.backgroundColor = [UIColor whiteColor];
    }
}
//此方法和上面的方法很重要，对ios 5SDK 设置不被Helighted
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    UIView *vMenuView = [self.contentView viewWithTag:100];
    if (vMenuView.hidden == YES) {
        [super setHighlighted:highlighted animated:animated];
    }
}

-(void)prepareForReuse{
    self.contentView.clipsToBounds = YES;
    [self hideMenuView:YES Animated:NO];
}


-(CGFloat)getMaxMenuWidth{
    return AGREE_BUTTON_WIDHT + UNAGREE_BUTTON_WIDTH+IGNORE_BUTTON_WIDTH;
}

-(void)enableSubviewUserInteraction:(BOOL)aEnable{
    if (aEnable) {
        for (UIView *aSubView in self.contentView.subviews) {
            aSubView.userInteractionEnabled = YES;
        }
    }else{
        for (UIView *aSubView in self.contentView.subviews) {
            UIView *vDeleteButtonView = [self.contentView viewWithTag:100];
            if (aSubView != vDeleteButtonView) {
                aSubView.userInteractionEnabled = NO;
            }
        }
    }
}

-(void)hideMenuView:(BOOL)aHide Animated:(BOOL)aAnimate{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    CGRect vDestinaRect = CGRectZero;
    if (aHide) {
        vDestinaRect = self.contentView.frame;
        [self enableSubviewUserInteraction:YES];
    }else{
        vDestinaRect = CGRectMake(-[self getMaxMenuWidth], self.contentView.frame.origin.x, self.contentView.frame.size.width, self.contentView.frame.size.height);
        [self enableSubviewUserInteraction:NO];
    }
    
    CGFloat vDuration = aAnimate? 0.4 : 0.0;
    [UIView animateWithDuration:vDuration animations:^{
        _moveContentView.frame = vDestinaRect;
    } completion:^(BOOL finished) {
        if (aHide) {
            if ([_delegate respondsToSelector:@selector(didCellHided:)]) {
                [_delegate didCellHided:self];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(didCellShowed:)]) {
                [_delegate didCellShowed:self];
            }
        }
        UIView *vMenuView = [self.contentView viewWithTag:100];
        vMenuView.hidden = aHide;
    }];
}


- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint vTranslationPoint = [gestureRecognizer translationInView:self.contentView];
        return fabs(vTranslationPoint.x) > fabs(vTranslationPoint.y);
    }
    return YES;
}

-(void)handlePan:(UIPanGestureRecognizer *)sender{
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"______________________");
        startLocation = [sender locationInView:self.contentView].x;
        CGFloat direction = [sender velocityInView:self.contentView].x;
        if (direction < 0) {
            if ([_delegate respondsToSelector:@selector(didCellWillShow:)]) {
                [_delegate didCellWillShow:self];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(didCellWillHide:)]) {
                [_delegate didCellWillHide:self];
            }
        }
    }else if (sender.state == UIGestureRecognizerStateChanged){
        CGFloat vCurrentLocation = [sender locationInView:self.contentView].x;
        CGFloat vDistance = vCurrentLocation - startLocation;
        startLocation = vCurrentLocation;
        
        CGRect vCurrentRect = _moveContentView.frame;
        CGFloat vOriginX = MAX(-[self getMaxMenuWidth] - BOUNENCE, vCurrentRect.origin.x + vDistance);
        vOriginX = MIN(0 + BOUNENCE, vOriginX);
        
        _moveContentView.frame = CGRectMake(vOriginX, vCurrentRect.origin.y, vCurrentRect.size.width, vCurrentRect.size.height);
        
        CGFloat direction = [sender velocityInView:self.contentView].x;
        NSLog(@"direction:%f",direction);
        NSLog(@"vOriginX:%f",vOriginX);
        if (direction < -40.0 || vOriginX <  - (0.5 * [self getMaxMenuWidth])) {
            hideMenuView = NO;
            UIView *vMenuView = [self.contentView viewWithTag:100];
            vMenuView.hidden = hideMenuView;
        }else if(direction > 20.0 || vOriginX >  - (0.5 * [self getMaxMenuWidth])){
            hideMenuView = YES;
        }
    }else if (sender.state == UIGestureRecognizerStateEnded){
        [self hideMenuView:hideMenuView Animated:YES];
    }
}

-(void)handleTap:(UITapGestureRecognizer *)sender{

    [self hideMenuView:YES Animated:YES];
}

#pragma mark  点击不同意
-(void)unAgreeButtonClicked:(id)sender{
    NSLog(@"点击不同意");
    if(_delegate && [_delegate respondsToSelector:@selector(applyCellRefuseFriendAtIndexPath:)])
    {
        [_delegate applyCellRefuseFriendAtIndexPath:self.indexPath];
    }
}

#pragma mark 点击同意
-(void)agreeButtonClicked:(id)sender{
    NSLog(@"点击同意");
    [self.superview sendSubviewToBack:self];
    if(_delegate && [_delegate respondsToSelector:@selector(applyCellAddFriendAtIndexPath:)])
    {
        [_delegate applyCellAddFriendAtIndexPath:self.indexPath];
    }
}

-(void)ignoreButtonClicked:(UIButton *)sender{
    NSLog(@"点击忽略");
    [self hideMenuView:YES Animated:YES];
    
#warning 此处处理忽略信息
    
//    EMConversation *converation = [self.dataSource objectAtIndex:indexPath.row];
//    [[EaseMob sharedInstance].chatManager removeConversationByChatter:converation.chatter deleteMessages:NO];
//    [self.dataSource removeObjectAtIndex:indexPath.row];
//    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
  

}

+ (CGFloat)heightWithContent:(NSString *)content
{
    if (!content || content.length == 0) {
        return 60;
    }
    else{
        CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(320 - 60 - 120, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
        return size.height > 20 ? (size.height + 40) : 60;
    }
}

@end
