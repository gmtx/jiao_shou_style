//
//  FriendDetailController.m
//  TeachThin
//
//  Created by myStyle on 14-11-27.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "FriendDetailController.h"
#import "UIViewController+HUD.h"
#import "AddFriendCell.h"
#import "WCAlertView.h"
#import "Macro.h"

@interface FriendDetailController ()<UIAlertViewDelegate>


@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) UILabel *noLabel;

@end

@implementation FriendDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@">>>>>>>>>>>>>self.dataSource:%@",self.dataSource);
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.title = @"好友详情";
    self.view.backgroundColor = RGBACOLOR(248, 248, 248, 1);
    [self initNav];
    [self initFriendDetailView];
    [self initAddFriendBtn];
}

//初始化导航的Item
-(void)initNav{

    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back_arow"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
}

//初始化好友详情视图
-(void)initFriendDetailView{
    self.friendDetailView = [[FriendDetailView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 110)];
    self.friendDetailView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    [self.friendDetailView renderUser:self.dataSource];
    [self.view addSubview:self.friendDetailView];
}

//初始化添加好友button
-(void)initAddFriendBtn{
    float addBtnY = self.friendDetailView.frame.origin.y + self.friendDetailView.frame.size.height+25;
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(30, addBtnY, self.view.frame.size.width-60, 44)];
    addButton.backgroundColor = RGBACOLOR(244, 44, 72, 1);
    [addButton setTitle:@"添加好友" forState:UIControlStateNormal];
    CALayer *layer = addButton.layer;
    [layer setCornerRadius:5];
    [addButton addTarget:self action:@selector(addFriendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
}

#pragma mark - 添加好友的button事件

-(void)addFriendBtnClick:(UIButton *)sender{
    NSString *buddyName = [self.dataSource objectAtIndex:0];
    if ([self didBuddyExist:buddyName]) {
        NSString *message = [NSString stringWithFormat:@"'%@'已经是你的好友了!", buddyName];
        [WCAlertView showAlertWithTitle:message
                                message:nil
                     customizationBlock:nil
                        completionBlock:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles: nil];
        
    }
    else if([self hasSendBuddyRequest:buddyName])
    {
        NSString *message = [NSString stringWithFormat:@"您已向'%@'发送好友请求了!", buddyName];
        [WCAlertView showAlertWithTitle:message
                                message:nil
                     customizationBlock:nil
                        completionBlock:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles: nil];
        
    }else{
        [self sendFriendApplyAtIndexPath:self.selectedIndexPath
                                 message:nil];
    }
}

#pragma mark - action

- (BOOL)hasSendBuddyRequest:(NSString *)buddyName
{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState == eEMBuddyFollowState_NotFollowed &&
            buddy.isPendingApproval) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)didBuddyExist:(NSString *)buddyName{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState != eEMBuddyFollowState_NotFollowed) {
            return YES;
        }
    }
    return NO;
}

- (void)sendFriendApplyAtIndexPath:(NSIndexPath *)indexPath
                           message:(NSString *)message
{
    NSString *buddyName = [self.dataSource objectAtIndex:indexPath.row];
    if (buddyName && buddyName.length > 0) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        EMError *error;
        [[EaseMob sharedInstance].chatManager addBuddy:buddyName message:message error:&error];
        [self hideHud];
        if (error) {
            [self showHint:@"发送申请失败，请重新操作"];
        }
        else{
            [self showHint:@"发送申请成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
