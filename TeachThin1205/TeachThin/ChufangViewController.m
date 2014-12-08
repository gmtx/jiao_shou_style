//
//  ChufangViewController.m
//  TeachThin
//
//  Created by 王园园 on 14-11-28.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "ChufangViewController.h"


@interface ChufangViewController ()

@end

@implementation ChufangViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"处方医嘱";
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
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT) style:UITableViewStyleGrouped];
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
-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}

#pragma mark -
#pragma mark - Httprequest
-(void)loadData
{
    NSString *urlstr = URL_PlanCFYZDetail;
    NSDictionary *pragma = [NSDictionary dictionaryWithObjectsAndKeys:_jieduanId,@"stageid",nil];
    JSHttpRequest *request = [[JSHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:urlstr pragma:pragma ImageData:nil];
    request.successGetData = ^(id obj){
        //如果获取到数据网络页面消失
        [self removeNonetView];
        //加载框消失
        [MBHUDView dismissCurrentHUD];
        NSDictionary *dict = (NSDictionary *)obj;
        _DataDict = [dict valueForKey:@"list"];
        NSLog(@"DataDict-----%@",_DataDict);
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
}


#pragma mark - UItableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if(section==0){
        return 2;
    }else
        return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell;
    UILabel *titleLable;
    UILabel *cotentLable;
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 120, 20)];
        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [cell addSubview:titleLable];
        
        cotentLable = [[UILabel alloc]initWithFrame:CGRectMake(130, 17, VIEW_WEIGHT-140, 20)];
        cotentLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        cotentLable.tag = 1000;
        cotentLable.backgroundColor = [UIColor clearColor];
        cotentLable.textColor = RGBACOLOR(111., 111., 111., 1);
        [cell addSubview:cotentLable];
    }
    if(indexPath.section==0){
        if(indexPath.row==0){
            titleLable.text = @"处方开始时间:";
            cotentLable.text = [ManageVC timePrToTime:[_DataDict  valueForKey:@"startdate"]];
        }else{
            titleLable.text = @"处方结束时间:";
            cotentLable.text = [ManageVC timePrToTime:[_DataDict  valueForKey:@"enddate"]];
        }
    }else if(indexPath.section==1){
        titleLable.text = @"此阶段摄入的能量值";
        titleLable.frame = CGRectMake(15, 15, 170, 20);
        cotentLable.frame = CGRectMake(170, 17, VIEW_WEIGHT-170, 20);
        cotentLable.text = [_DataDict valueForKey:@"energy"];
    }else{
        titleLable.text = @"处方医嘱";
        cotentLable.text = [_DataDict valueForKey:@"title"];
    }
    cotentLable.numberOfLines = 0;
    [cotentLable sizeToFit];
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:table cellForRowAtIndexPath:indexPath];
    UILabel *lable = (UILabel *)[cell viewWithTag:1000];
    return lable.frame.size.height+30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.;
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
