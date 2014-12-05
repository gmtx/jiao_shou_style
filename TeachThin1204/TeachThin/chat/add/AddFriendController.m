//
//  AddFriendController.m
//  TeachThin
//
//  Created by myStyle on 14-11-27.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "AddFriendController.h"
#import "FriendDetailController.h"

@interface AddFriendController ()<UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *noSource;

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) UILabel *noLabel;

@end

@implementation AddFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.noSource = [NSMutableArray array];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.title = @"查找好友";
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.tableView.tableHeaderView = self.headerView;
    
    //    UIView *footerView = [[UIView alloc] init];
    //    footerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    //    self.tableView.tableFooterView = footerView;
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:32 / 255.0 green:134 / 255.0 blue:158 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:searchButton]];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back_arow"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    [self.view addSubview:self.textField];
    [self headerView];
    [self initNOLabel];
}
#pragma mark - getter

- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 40)];
        _textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _textField.layer.borderWidth = 0.5;
        _textField.layer.cornerRadius = 3;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:15.0];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = @"输入手机号";
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
    }
    
    return _textField;
}

-(void)initNOLabel{
    self.noLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 40)];
    self.noLabel.text = @"输入手机号查找";
    [self.view addSubview:self.noLabel];
}

- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 60)];
        //        _headerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        [_headerView addSubview:_textField];
        [self.view addSubview:_headerView];
    }
    
    return _headerView;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - action

- (void)searchAction
{
    [_textField resignFirstResponder];
    if(_textField.text.length > 0)
    {
#warning 由用户体系的用户，需要添加方法在已有的用户体系中查询符合填写内容的用户
#warning 以下代码为测试代码，默认用户体系中有一个符合要求的同名用户
//        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
//        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
//        if ([_textField.text isEqualToString:loginUsername]) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能添加自己为好友" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//            return;
//        }
//        
        //判断是否已发来申请
        //        NSArray *applyArray = [[ApplyViewController shareController] dataSource];
        //        if (applyArray && [applyArray count] > 0) {
        //            for (ApplyEntity *entity in applyArray) {
        //                ApplyStyle style = [entity.style intValue];
        //                BOOL isGroup = style == ApplyStyleFriend ? NO : YES;
        //                if (!isGroup && [entity.applicantUsername isEqualToString:_textField.text]) {
        //                    NSString *str = [NSString stringWithFormat:@"%@已经给你发来了申请", _textField.text];
        //                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //                    [alertView show];
        //
        //                    return;
        //                }
        //            }
        //        }
        
        [self.noSource removeAllObjects];
        [self.noSource addObject:_textField.text];
        FriendDetailController *fdc = [[FriendDetailController alloc] init];
        fdc.dataSource = self.noSource;
        NSLog(@">>>>>>>>>>>>>fdc.dataSource:%@",fdc.dataSource);
        [self.navigationController pushViewController:fdc animated:YES];
        
    }
}



@end
