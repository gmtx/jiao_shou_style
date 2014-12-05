//
//  CollectionViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的收藏";
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arow"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnPress) ];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}
-(void)backBtnPress
{
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:(index-1)] animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT/2-25, VIEW_HEIGHT-60, 50, 50);
    homeBtn.backgroundColor = [UIColor purpleColor];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
}

-(void)viewDidAppear:(BOOL)animated
{
    
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
    return 4;
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
        img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 55,55)];
        img.layer.cornerRadius = 5.;
        [cell.contentView addSubview:img];
        
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_MAXX(img)+10, 15, VIEW_WEIGHT-90, 20)];
        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
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
    return 70.;
}

//设置单元格的可编辑状态
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//编辑单元格所执行的操作
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
    //删除数据
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
