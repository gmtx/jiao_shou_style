//
//  SpSearchViewController.m
//  TeachThin
//
//  Created by 王园园 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "SpSearchViewController.h"

@interface SpSearchViewController ()

@end

@implementation SpSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backbtn"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnPress) ];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}
-(void)backBtnPress
{
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:(index-1)] animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 60.0, VIEW_WEIGHT, 45)];
    mySearchBar.barStyle=UIBarStyleDefault;
    mySearchBar.placeholder=@"这里有你想要的";
    [mySearchBar becomeFirstResponder];
    mySearchBar.delegate = self;
    self.navigationItem.titleView = mySearchBar;
    //[self.view addSubview:mySearchBar];
    [self showRecentTable:YES];
}

//搜索框刚输入出发的事件：
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    [self startWorking];
    
}

//添加Cancel事件：
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"12345465");
    
    searchBar.text=@"";
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    [self endWorking];
}
//添加搜索事件：
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self endWorking];
}

#pragma mark -
- (void)startWorking
{
    _viewBlackCover = [[UIView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WEIGHT, VIEW_HEIGHT-64)];
    _viewBlackCover.backgroundColor = [UIColor blackColor];
    _viewBlackCover.alpha = 0.0f;
    [self.view addSubview:_viewBlackCover];
    [UIView animateWithDuration:0.4f animations:^()
     {
         _viewBlackCover.alpha = 0.3f;
     }completion:^(BOOL f){}];
    
    if (![mySearchBar isFirstResponder])
    {
        [mySearchBar becomeFirstResponder];
    }else{}
    [ self setRecentKeyword:[NSArray arrayWithObjects:@"有氧",@"无氧",@"瑜伽",nil]];
    [self showRecentTable:YES];
    
    _bIsWorking = YES;
}

- (void)endWorking
{
    _bIsWorking = NO;
    [_viewBlackCover removeFromSuperview];
    [self showRecentTable:NO];
}

- (void)setRecentKeyword:(NSArray *)arrRecentKeyword
{
    if (arrRecentKeyword)
    {
        _arrRecent = [NSArray arrayWithArray:arrRecentKeyword];
    }
    else
    {
        _arrRecent = nil;
    }
    if (tableView)
    {
        [tableView reloadData];
    }else{}
}

- (void)setKeyword:(NSString *)strKeyword
{
    if (mySearchBar)
    {
        [mySearchBar setText:strKeyword];
    }else{}
}


- (void)showRecentTable:(BOOL)bIsShow
{
    if (bIsShow && _arrRecent && (_arrRecent.count > 0))
    {
        if (!tableView)
        {
            tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT) style:UITableViewStylePlain];
            [self.view addSubview:tableView];
            UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, 40)];
            UILabel *headLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, VIEW_WEIGHT, 40)];
            headLable.text = @"搜索历史";
            headLable.font = [UIFont boldSystemFontOfSize:16.];
            headLable.textColor = [UIColor darkGrayColor];
            [headView addSubview:headLable];
            tableView.tableHeaderView = headView;
            
            UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 240.0f)];
            footer.backgroundColor = [UIColor clearColor];
            tableView.tableFooterView = footer;
            UIButton *btnClearSearchRecord = [UIButton buttonWithType:UIButtonTypeCustom];
            btnClearSearchRecord.frame = CGRectMake(0.0f, 20.0f, footer.frame.size.width, 50.0f);
            [btnClearSearchRecord setTitle:@"清除搜索记录" forState:UIControlStateNormal];
            [btnClearSearchRecord setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btnClearSearchRecord setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
            [btnClearSearchRecord addTarget:self action:@selector(btnClearSearchRecord:) forControlEvents:UIControlEventTouchUpInside];
            [footer addSubview:btnClearSearchRecord];
            
            tableView.backgroundColor = RGBACOLOR(232., 232., 232., 1);
            tableView.delegate = self;
            tableView.dataSource = self;
        }else{}
        tableView.hidden = NO;
        
        tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y+tableView.frame.size.height, tableView.frame.size.width, tableView.frame.size.height);
        [UIView animateWithDuration:0.3f animations:^()
         {
             tableView.frame = CGRectMake(0, 64, VIEW_WEIGHT, VIEW_HEIGHT-64);
         }];
    }
    else
    {
        if (tableView)
        {
            [tableView removeFromSuperview];
            tableView = nil;
        }else{}
    }
}
- (void)btnClearSearchRecord:(id)sender
{
    _arrRecent = nil;
    [tableView removeFromSuperview];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger iCount = _arrRecent ? _arrRecent.count : 0;
    return iCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchTypeCell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor whiteColor];
  
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *strKeyword = _arrRecent[indexPath.row];
    cell.textLabel.text = strKeyword;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strKeyword = _arrRecent[indexPath.row];
    [mySearchBar setText:strKeyword];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
