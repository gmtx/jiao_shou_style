//
//  SpecialCrowdViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-24.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "SpecialCrowdViewController.h"

@interface SpecialCrowdViewController ()

@end

@implementation SpecialCrowdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"劳动强度";
        
        sureBtn = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureBtnClick:)];
        self.navigationItem.rightBarButtonItem = sureBtn;
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arr = [NSArray arrayWithObjects:@"孕妇",@"精神病患者",@"残疾人",@"21三体综合症患者", nil];
    [self setlayout];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [_postArr removeAllObjects];
    _postArr = [[NSMutableArray alloc]init];
    [table reloadData];
}

-(void)setlayout
{
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, WIDTH_VIEW(self.view), VIEW_HEIGHT) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.scrollEnabled = NO;
    table.bounces = NO;
    
    table.rowHeight = 44;
    [table setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    [self.view addSubview:table];
}
#pragma table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [_arr count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    cell.textLabel.text = [_arr objectAtIndex:indexPath.section];
    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16.0];
    cell.textLabel.textColor=[UIColor blackColor];
    
    
    
    
    selectBtn = [GXSelectBtn buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(0, 0, WIDTH_VIEW(cell), 44);
    selectBtn.backgroundColor = [UIColor clearColor];
    [selectBtn setImageEdgeInsets:UIEdgeInsetsMake(8.0,8.0, 8.0, 8.0)];
    
    selectBtn.tag = 1000+indexPath.section;
    selectBtn.info =  [_arr objectAtIndex:indexPath.section];
    [selectBtn addTarget:self action:@selector(selectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
     selectBtn.Btnimg.hidden = YES;
    [cell.contentView addSubview:selectBtn];
    selectBtn.selected = NO;
    
    [_postArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(obj==selectBtn.info ){
            selectBtn.selected = YES;
            NSLog(@"**************%d",indexPath.section);
        }
    }];
    
    
    
    
    
    
    return cell;
    
}
-(void)selectBtnPress:(id)sender
{
    //获取点击的按钮
    GXSelectBtn *btn = (GXSelectBtn *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.Btnimg.hidden = NO;
        [_postArr addObject:btn.info];
        NSLog(@"****************%@",_postArr);
        
    }else
    {
        btn.Btnimg.hidden = YES;
        [_postArr removeObject:btn.info];
        NSLog(@"****************%@",_postArr);
        
    }
    
    
}




-(void)sureBtnClick:(id)sender
{
    
    NSLog(@"***********%@",_postArr);
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"special" object:_postArr];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
