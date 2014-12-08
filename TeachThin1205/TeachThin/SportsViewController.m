//
//  SportsViewController.m
//  TeachThin
//
//  Created by 王园园 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "SportsViewController.h"
#import "SpDetailViewController.h"
#import "SpSearchViewController.h"

@interface SportsViewController ()

@end

@implementation SportsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"每日运动";
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"SearchBtn"] style:UIBarButtonItemStyleBordered target:self action:@selector(SearchBtnPress)];
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

-(void)SearchBtnPress
{
    SpSearchViewController *searchVC = [[SpSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (void)viewDidLoad
{
    // Do any additional setup after loading the view.
    _segDataArr = @[@"有氧",@"无氧",@"瑜伽",@"游泳",@"跑步",@"柔道",@"剑术"];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT-70, VIEW_HEIGHT-60, 50, 50);
    homeBtn.backgroundColor = [UIColor purpleColor];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    [self SetMenuView];
}

-(void)SetMenuView
{
    MenuView = [[ListMenuView alloc]initWithFrame:CGRectMake(-100,0, 120, self.view.frame.size.height)];
    [MenuView setUserInteractionEnabled:YES];
    [MenuView setListDataArr:@[@"有氧",@"无氧",@"瑜伽",@"体操",@"舞蹈"]];
    MenuView.ListTable.backgroundColor = RGBACOLOR(247.,247., 249., 1);
    MenuView.ListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:MenuView];
    [MenuView setTapActionBlock:^(NSInteger Index) {
        NSLog(@"Taped is:%d",Index);
    }];
}

-(void)HomeBtnPress{
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
#pragma mark - UItableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return (arc4random()%5) +2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell;
    UILabel *titleLable;
    UIImageView *img;
    UILabel *detaillable;
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        img.layer.cornerRadius = 5.;
        [cell.contentView addSubview:img];
        
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_MAXX(img)+10, 25, VIEW_WEIGHT-90, 20)];
        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [cell.contentView addSubview:titleLable];
        
        detaillable = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_MAXX(img)+10, VIEW_MAXY(titleLable)+7, VIEW_WEIGHT-90, 30)];
        detaillable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        detaillable.backgroundColor = [UIColor clearColor];
        detaillable.textColor =[[UIColor grayColor] colorWithAlphaComponent:0.8];
        [cell.contentView addSubview:detaillable];
    }
    img.backgroundColor = [UIColor blueColor];
    titleLable.text = @"中背部肌肉";
    detaillable.text = @"固定阻力与腰高中背部肌肉";
    detaillable.numberOfLines = 2;
    [detaillable sizeToFit];
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"_____selected_____");
    SpDetailViewController *detailVC = [[SpDetailViewController alloc]init];
    /////////////////
    detailVC.titleStr = @"中背部肌肉";
    detailVC.detailStr = @"固定阻力与腰高中背部肌肉";
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
