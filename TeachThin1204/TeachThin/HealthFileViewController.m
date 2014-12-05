//
//  HealthFileViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-14.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "HealthFileViewController.h"
#import "ManageVC.h"
//拍一拍接口http://www.gmtxw01.com/index.php?m=product&c=index&a=food_decription&foodname=aaaa
#define URL_PhotoData(name)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=product&c=index&a=food_decription&foodname=%@",name]]
//拍一拍单品食物交换分
#define URL_JiaohuanfenData [MAINURL stringByAppendingString:[NSString stringWithFormat:@"http://www.gmtxw01.com/index.php?m=product&c=index&a=food_exchang"]]


//首页计划执行状态列表http://www.gmtxw01.com/index.php?index.php?m=hkiyun&c=plan&a=init
#define URL_MyPlanStatus  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=hkiyun&c=plan&a=init"]]
//计划详情页(post)http://www.gmtxw01.com/index.php?index.php?m=hkiyun&c=plan&a=infor
#define URL_MyPlanDetail  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=hkiyun&c=plan&a=infor"]]
//阶段计划日历状态列表http://www.gmtxw01.com/index.php?index.php?m=hkiyun&c=plan&a=details
#define URL_JDPlanDetail  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=hkiyun&c=plan&a=details"]]
//处方医嘱http://www.gmtxw01.com/index.php?index.php?m=hkiyun&c=plan&a=prescription
#define URL_PlanCFYZDetail [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=hkiyun&c=plan&a=prescription"]]
//处方医嘱http://www.gmtxw01.com/index.php?index.php?m=hkiyun&c=plan&a=advice
#define URL_PlanYZDetail [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=hkiyun&c=plan&a=advice"]]
@interface HealthFileViewController ()

@end

@implementation HealthFileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"健康档案";
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
    header = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH_VIEW(self.view), 37)];
    header.backgroundColor = RGBACOLOR(33., 41., 51., 1);
    
    dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dateBtn.backgroundColor = [UIColor clearColor];
    dateBtn.frame = CGRectMake(10, 0, 150, 37);
    _Currentdate = [ManageVC DateStrFromDate:[NSDate date] Withformat:@"yyyy-MM-dd"];
    NSString *weekStr = [ManageVC getWeekday:[NSDate date]];
    [dateBtn setTitle:[NSString stringWithFormat:@"%@  %@",weekStr,_Currentdate] forState:UIControlStateNormal];
    [dateBtn setImage:[UIImage imageNamed:@"arow_xia"] forState:UIControlStateNormal];
    [dateBtn setImageEdgeInsets:UIEdgeInsetsMake(7.0, 130.0, 5.0, 0.0)];
    [dateBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -20.0, 0.0, 20.0)];
    dateBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    [dateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(DateBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:dateBtn];
    [self.view addSubview:header];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, WIDTH_VIEW(self.view), HEIGHT_VIEW(self.view)-100) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    UILabel *bottomLable = [[UILabel alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT-35, VIEW_WEIGHT, 35)];
    bottomLable.backgroundColor = RGBACOLOR(22., 20., 20., 1);
    bottomLable.text = @"  默认显示一周，体重单位是kg";
    bottomLable.textColor = [UIColor whiteColor];
    bottomLable.font = [UIFont boldSystemFontOfSize:14.];
    [self.view addSubview:bottomLable];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT-70, VIEW_HEIGHT-60, 50, 50);
    homeBtn.backgroundColor = [UIColor purpleColor];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    
}


-(void)DateBtnPress:(UIButton *)btn
{
    [self setdateSheet];
}

-(void)HomeBtnPress
{
//    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}


#pragma mark -
#pragma mark - Httprequest
-(void)loadData
{
    NSString *urlstr = @"";
    JSHttpRequest *request = [[JSHttpRequest alloc]init];
    [request StartWorkWithUrlstr:urlstr];
    request.successGetData = ^(id obj){
        //如果获取到数据网络页面消失
        [self removeNonetView];
        //加载框消失
        [MBHUDView dismissCurrentHUD];
    };
    request.failureGetData = ^(void){
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


-(void)viewDidAppear:(BOOL)animated
{
    [self setCell1View];
    [self SetCell2Vlew];
    [table reloadData];
}
#pragma mark - ADDData
-(void)setCell1View
{
    cell1View = [[UIView alloc]initWithFrame:CGRectMake(0,0, VIEW_WEIGHT, 160)];
    cell1View.userInteractionEnabled = YES;
    UILabel *Lable1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 40, 35)];
    Lable1.backgroundColor = [UIColor whiteColor];
    Lable1.text = @"体重";
    Lable1.textColor = [UIColor blackColor];
    Lable1.font = [UIFont boldSystemFontOfSize:14.];
    [cell1View addSubview:Lable1];
    
    self.slider = [[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(70, 30, 220, 50)];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveSuffix:@"kg"];
    self.slider.backgroundColor = [UIColor clearColor];
    self.slider.maximumValue = 100.0;
    [self.slider setNumberFormatter:formatter];
    self.slider.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:12.];
    self.slider.popUpViewAnimatedColors = @[[UIColor greenColor],[UIColor yellowColor], [UIColor orangeColor], [UIColor redColor]];
    [self.slider setThumbImage:[UIImage imageNamed:@"transparent"] forState:UIControlStateHighlighted];
    [self.slider setThumbImage:[UIImage imageNamed:@"transparent"] forState:UIControlStateNormal];
    UIImage *stetchLeftTrack = [[UIImage imageNamed:@"colorline.png"]stretchableImageWithLeftCapWidth:80.0 topCapHeight:0.0];
    [self.slider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    _slider.value = 45.;
    [self.slider showPopUpView];
    [cell1View addSubview:_slider];
   
    
    UILabel *Lable2 = [[UILabel alloc]initWithFrame:CGRectMake(20,105, VIEW_WEIGHT, 35)];
    Lable2.backgroundColor = [UIColor whiteColor];
    Lable2.text = @"BMI";
    Lable2.textColor = [UIColor blackColor];
    Lable2.font = [UIFont boldSystemFontOfSize:14.];
    [cell1View addSubview:Lable2];
    
    self.slider2 = [[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(70, 90, 220, 60)];
    NSNumberFormatter *formatter2 = [[NSNumberFormatter alloc] init];
    self.slider2.backgroundColor = [UIColor clearColor];
    self.slider2.maximumValue = 100.0;
    [self.slider2 setNumberFormatter:formatter2];
    self.slider2.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:12.];
    [self.slider2 showPopUpView];
    self.slider2.popUpViewAnimatedColors = @[[UIColor greenColor],[UIColor yellowColor], [UIColor orangeColor], [UIColor redColor]];
    //取掉大圆圈
    [self.slider2 setThumbImage:[UIImage imageNamed:@"transparent"] forState:UIControlStateHighlighted];
    [self.slider2 setThumbImage:[UIImage imageNamed:@"transparent"] forState:UIControlStateNormal];
    //
    [self.slider2 setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [self.slider2 setMaximumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    _slider2.value = 25.;
    [cell1View addSubview:_slider2];
}

-(void)SetCell2Vlew
{
    cell2View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, 300)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, 30)];
    lable.backgroundColor = [UIColor lightGrayColor];
    lable.textColor = [UIColor blackColor];
    lable.text = @"   体重趋势图";
    lable.font = [UIFont boldSystemFontOfSize:14.];
    [cell2View addSubview:lable];
    [cell2View addSubview:[self chart1]];
}
-(FSLineChart*)chart1 {
    // Generating some dummy data
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:7];
    
    for(int i=0;i<7;i++) {
        chartData[i] = [NSNumber numberWithInt:rand() % 90];
    }
    
    // Creating the line chart
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(30, 40, VIEW_WEIGHT-44, 180)];

    lineChart.gridStep = 7;

    lineChart.labelForIndex = ^(NSUInteger item) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)item];
    };
    
    lineChart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.f", value];
    };
    
    [lineChart setChartData:chartData];
    
    return lineChart;
}


#pragma table delegate
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(cell==nil){
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    if(indexPath.row==0){
        [cell.contentView addSubview:cell1View];
    }else{
        [cell.contentView addSubview:cell2View];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 160;
    }else{
        return 300;
    }
}


-(void)setdateSheet
{
    DateSheetView =[[YYActionsheet alloc] initWithHeight:300.0f WithSheetTitle:@"选择区域"];
    __weak HealthFileViewController *vc = self;
    DateSheetView.OKBtnbloack = ^(){
    
        NSString *weekStr = [ManageVC getWeekday:[vc.datePicker date]];
        [dateBtn setTitle:[NSString stringWithFormat:@"%@  %@",weekStr,_Currentdate] forState:UIControlStateNormal];
    };
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, VIEW_WEIGHT, 200)];
    // 设置时区
    [_datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    // 设置当前显示时间
    [_datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [_datePicker setMaximumDate:[NSDate date]];
    // 设置UIDatePicker的显示模式
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    // 当值发生改变的时候调用的方法
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [DateSheetView addSubview:_datePicker];
    [DateSheetView showInView:self.view];
    
}

-(void)datePickerValueChanged:(UIDatePicker *)picker
{
    NSDate *date = [picker date];
   
    _Currentdate = [ManageVC DateStrFromDate:date Withformat:@"yyyy-MM-dd"];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
