//
//  YiZhuViewController.m
//  TeachThin
//
//  Created by 王园园 on 14-11-27.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "YiZhuViewController.h"

@interface YiZhuViewController ()

@end

@implementation YiZhuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"查看医嘱";
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
    _segIndex = 0;
    NSArray *titleArr = @[@"医嘱内容",@"饮食建议",@"目标控制",@"运动建议"];
    _titleKeyArr = @[@"content",@"diet",@"control",@"movement"];
    segView  = [[CustomSegView alloc]initWithFrame:CGRectMake(0, 66, VIEW_WEIGHT, 40)];
    segView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    __weak YiZhuViewController *vc = self;
    segView.SegBtntap = ^(NSInteger tag){
        NSLog(@"selected:%d",tag);
        //刷新tableView
        vc.segIndex = tag;
        [table reloadData];
    };
    [segView setTitleArr:titleArr];
    [self.view addSubview:segView];

    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, VIEW_WEIGHT, VIEW_HEIGHT-104) style:UITableViewStyleGrouped];
    table.backgroundColor = [UIColor whiteColor];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT-70, VIEW_HEIGHT-60, 50, 50);
    [homeBtn setImage:[UIImage imageNamed:@"homeBtn"] forState:UIControlStateNormal];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    
}
-(void)HomeBtnPress
{
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadData];
}

#pragma mark -
#pragma mark - Httprequest
-(void)loadData
{
    NSString *urlstr = URL_PlanYZDetail;
    NSDictionary *pragma = [NSDictionary dictionaryWithObjectsAndKeys:_planId,@"planid",nil];
    JSHttpRequest *request = [[JSHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:urlstr pragma:pragma ImageData:nil];
    request.successGetData = ^(id obj){
        //如果获取到数据网络页面消失
        [self removeNonetView];
        //加载框消失
        [MBHUDView dismissCurrentHUD];
        NSDictionary *dict = (NSDictionary *)obj;
        _Datadict = [dict valueForKey:@"list"];
        NSLog(@"DataDict-----%@",dict);
        [table reloadData];
    };
    request.failureGetData = ^(void){
        [MBHUDView dismissCurrentHUD];
        [self showNoNetView];//显示没有网络页面
        
    };
}

-(void)showNoNetView;
{
    [NonetView shareNetView].delegate = self;
    [self.view addSubview:[NonetView shareNetView]];
    
}
-(void)removeNonetView;
{
    [[NonetView shareNetView] removeFromSuperview];
}

-(void)NetViewReloadData
{
    NSLog(@"________reload____________");
    [MBHUDView hudWithBody:@"加载中" type:MBAlertViewHUDTypeActivityIndicator hidesAfter:100000.0 show:YES];
    [self loadData];
}


#pragma mark - UItableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell;
    UILabel *titleLable;
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, VIEW_WEIGHT-20, 40)];
        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        titleLable.tag = 1000;
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [cell addSubview:titleLable];
    }
    titleLable.text = [_Datadict valueForKey:_titleKeyArr[_segIndex]];
    titleLable.numberOfLines = 0;
    [titleLable sizeToFit];
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:table cellForRowAtIndexPath:indexPath];
    UILabel *lable = (UILabel *)[cell viewWithTag:1000];
    if(HEIGHT_VIEW(lable)>100){
        return lable.frame.size.height+30;
    }else{
        return 100;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
