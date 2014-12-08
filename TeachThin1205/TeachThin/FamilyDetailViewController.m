//
//  FamilyDetailViewController.m
//  TeachThin
//
//  Created by 王园园 on 14-11-24.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "FamilyDetailViewController.h"

@interface FamilyDetailViewController ()
{
    NSArray * dayArray;
    
    int strMonth;
    int strYear;
    bool timePacker;
    
}


@end

@implementation FamilyDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        strYear = [[Datetime GetYear:[NSDate date]] intValue];
        strMonth = [[Datetime GetMonth:[NSDate date]] intValue];
        dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
        timePacker = YES;
        
        
        self.title = @"家人详情";
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
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT-60) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    [self setHeaderView];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT-60, VIEW_WEIGHT, 60)];
    footView.backgroundColor = RGBACOLOR(213., 213., 213., 1);
    [self.view addSubview:footView];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(15,10, VIEW_WEIGHT-20, 20)];
    lable1.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    NSMutableAttributedString * str2 = [[NSMutableAttributedString alloc]initWithString:@"完成的用绿色 未完成的用红色 灰色是未上传"];
    [str2 addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(46., 157., 30., 1) range:NSMakeRange(4,2)];
    [str2 addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(242., 12., 32., 1) range:NSMakeRange(12,2)];
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(15,2)];
    lable1.attributedText = str2 ;
    lable1.backgroundColor = [UIColor clearColor];
    lable1.textAlignment = NSTextAlignmentLeft;
    lable1.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    [footView addSubview:lable1];
    
    InfoLable = [[UILabel alloc]initWithFrame:CGRectMake(15,33, VIEW_WEIGHT-20, 20)];
    InfoLable.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    InfoLable.backgroundColor = [UIColor clearColor];
    InfoLable.textAlignment = NSTextAlignmentLeft;
    InfoLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    InfoLable.text = @"现在体重：--kg 减肥：--kg 目标体重：--kg";
    [footView addSubview:InfoLable];
}

-(void)setHeaderView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, 110)];
    
    userimgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 55, 55)];
    userimgView.backgroundColor = [UIColor yellowColor];
    userimgView.layer.cornerRadius = 25.;
    [headView addSubview:userimgView];
    
    titleLable = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, VIEW_WEIGHT-30, 20)];
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    titleLable.text = @"刘小小";
    [headView addSubview:titleLable];
    
    phoneLable = [[UILabel alloc]initWithFrame:CGRectMake(80, VIEW_MAXY(titleLable)+5, VIEW_WEIGHT-30, 20)];
    phoneLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    phoneLable.backgroundColor = [UIColor clearColor];
    phoneLable.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    phoneLable.text = @"刘小小";
    [headView addSubview:phoneLable];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 80, VIEW_WEIGHT, 30)];
    view.backgroundColor = RGBACOLOR(213., 213., 213., 1);
    [headView addSubview:view];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, view.frame.size.height)];
    lable.text = @"  百天计划";
    lable.textColor = [UIColor blackColor];
    lable.font = [UIFont systemFontOfSize:14.];
    lable.backgroundColor = [UIColor clearColor];
    [view addSubview:lable];
    
    UILabel *nowDatelable = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 120,view.frame.size.height)];
    nowDatelable.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    nowDatelable.font = [UIFont systemFontOfSize:14.];
    NSString *Currentdate = [ManageVC DateStrFromDate:[NSDate date] Withformat:@"yyyy-MM-dd"];
    nowDatelable.text = Currentdate;
    [view addSubview:nowDatelable];
    
    UIImageView *jianduimg = [[UIImageView alloc]initWithFrame:CGRectMake(VIEW_WEIGHT-50, 0, 50,30)];
    jianduimg.image = [UIImage imageNamed:@"Jiandu"];
    [view addSubview:jianduimg];
    table.tableHeaderView = headView;
}


-(void)viewDidAppear:(BOOL)animated
{
    [self loadData];
//    userimgView.image = ;
//    titleLable.text = ;
//    phoneLable.text = ;
}

#pragma mark -
#pragma mark - Httprequest
-(void)loadData
{
    _uid = @"1";
    NSString *urlstr = URL_FamilyPlan;
    NSDictionary *pragma = [NSDictionary dictionaryWithObjectsAndKeys:_uid,@"uid",nil];
    JSHttpRequest *request = [[JSHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:urlstr pragma:pragma ImageData:nil];
    request.successGetData = ^(id obj){
        //如果获取到数据网络页面消失
        [self removeNonetView];
        //加载框消失
        [MBHUDView dismissCurrentHUD];
        _DataDict = (NSDictionary *)obj;
        NSLog(@"DataDict-----%@",_DataDict);
        if([[_DataDict valueForKey:@"code"]isEqualToString:@"01"]){
            _StatusArr = [NSArray arrayWithArray:[_DataDict valueForKey:@"list"]];
            NSLog(@"StatuaArr----%@",_StatusArr);
            _startDate = [[[_StatusArr objectAtIndex:0] valueForKey:@"date"] longLongValue];
            _endDate = [[[_StatusArr lastObject] valueForKey:@"date"] longLongValue];
            [self reloadDaybuttenToCalendarWatch] ;
            //改变底部数值
            NSString *InfoStr = [NSString stringWithFormat:@"现在体重:%@kg  减肥:%@  目标体重:%@kg",[_DataDict valueForKey:@"weight"],[_DataDict valueForKey:@"start_weight"],[_DataDict valueForKey:@"dreamkg"]];
            InfoLable.text = InfoStr;
        }
    };
    request.failureGetData = ^(void){
        [self showNoNetView];//显示没有网络页面
        [MBHUDView dismissCurrentHUD];
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
    [self loadData];
    [MBHUDView hudWithBody:@"加载中" type:MBAlertViewHUDTypeActivityIndicator hidesAfter:100000.0 show:YES];
}



-(void)setCell2View
{
    Calendercell.frame = CGRectMake(0, 0, VIEW_WEIGHT, 310);
    Calendercell.backgroundColor = [UIColor whiteColor];
     [self AddHandleSwipe];
    [Calendercell addSubview:[self CreatTitleView]];
    NSMutableArray* weekarr = [[NSMutableArray alloc]initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    for (int i = 0; i < 7; i++) {
        UILabel* lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithString:weekarr[i]];
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = [UIColor clearColor];
        lable.frame = CGRectMake(i*45.7, 40,45.7, 26);
        lable.adjustsFontSizeToFitWidth = YES;
        lable.font = [UIFont systemFontOfSize:12.0f];
        lable.textAlignment = NSTextAlignmentCenter;
        [Calendercell addSubview:lable];
    }
    [self AddDaybuttenToCalendarWatch];
 
}
-(UIView*)CreatTitleView
{
    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_VIEW(self.view)/2-40, 0, 80, 40)];
    titleview.backgroundColor = [UIColor clearColor];
    [titleview addSubview:[self CalendarTitleLabel]];
    titleview.tag = 3000;
    return titleview;
}

//制作阳历lable
-(UILabel *)CalendarTitleLabel{
    
    UILabel* calendarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 ,80, 40)];
    calendarTitleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    calendarTitleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    calendarTitleLabel.textColor = [UIColor grayColor];
    if ((strYear == [[Datetime GetYear:[NSDate date]] intValue])&&(strMonth ==[[Datetime GetMonth:[NSDate date]] intValue])){
        calendarTitleLabel.text = [Datetime getDateTime];
    }else {
        if (strMonth < 10) {
            calendarTitleLabel.text = [NSString stringWithFormat:@"%d年  %d月",strYear,strMonth];
        }else calendarTitleLabel.text = [NSString stringWithFormat:@"%d年%d月",strYear,strMonth];
    }
    //设置标题
    
    //calendarTitleLabel.text = [Datetime getDateTime];  //设置标题
    calendarTitleLabel.hidden = NO;
    calendarTitleLabel.tag = 2001;
    calendarTitleLabel.adjustsFontSizeToFitWidth = YES;
    return calendarTitleLabel;
}
//在CalendarWatch中重新部署数据
-(void)reloadDateForCalendarWatch{
    dayArray = nil;
    dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
    
    NSLog(@"strMonth===%d",strMonth);
    
    [self reloadDaybuttenToCalendarWatch];
    [Calendercell addSubview:[self CreatTitleView]];
    
    
   
}
-(void)reloadDaybuttenToCalendarWatch{
    for (int i = 0; i < 42; i++)
        [[Calendercell viewWithTag:301+i] removeFromSuperview];
    [self AddDaybuttenToCalendarWatch];
}
-(void)AddDaybuttenToCalendarWatch{
    float calenderHeight = 40;
    if(VIEW_HEIGHT>500){
        calenderHeight = 60;
    }
    for (int i = 0; i < 42; i++) {
        UIButton * butten = [[UIButton alloc]init];
        butten.frame = CGRectMake((i%7)*45.7, 76+(i/7)*calenderHeight, 45.7, 40);
        [butten setTag:i+301];
        [butten addTarget:self action:@selector(buttenTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        butten.showsTouchWhenHighlighted = YES;
        
        UILabel * linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45.7, 1)];
        linelabel.backgroundColor = RGBACOLOR(207., 207., 207., 1);
        [butten addSubview:linelabel];
        
        
        UILabel* lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithString:dayArray[i]];
        lable.textColor = [UIColor lightGrayColor];
        lable.backgroundColor = [UIColor clearColor];
        lable.frame = CGRectMake(7.5, 5, 30, 30);
        lable.adjustsFontSizeToFitWidth = YES;
        lable.layer.masksToBounds = YES;
        lable.layer.cornerRadius = 15;
        [butten addSubview:lable];
        
        
        if (([[Datetime GetDay:[NSDate date]] intValue]== [dayArray[i] intValue])&&(strMonth == [[Datetime GetMonth:[NSDate date]] intValue])&&(strYear == [[Datetime GetYear:[NSDate date]] intValue])) {
            lable.backgroundColor = [UIColor blueColor];
            lable.textColor = [UIColor whiteColor];
        }
        
        //判断5个状态
        [_StatusArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[obj valueForKey:@"date"] longLongValue]];
            if(([[Datetime GetDay:date] intValue]== [dayArray[i] intValue])&&(strMonth == [[Datetime GetMonth:date] intValue])&&(strYear == [[Datetime GetYear:date] intValue])) {
                //1绿色已完成 0红色未完成2灰色点 3未开始
                if([[obj valueForKey:@"state"] integerValue]==3){
                    lable.backgroundColor = [UIColor clearColor];
                    lable.textColor = [UIColor blackColor];//锁定到某天
                }else if([[obj valueForKey:@"state"] integerValue]==1){
                    lable.backgroundColor = RGBACOLOR(30., 153., 10, 1);
                    lable.textColor = [UIColor whiteColor];
                }else if([[obj valueForKey:@"state"] integerValue]==0){
                    lable.backgroundColor = RGBACOLOR(237., 38., 48., 1);
                    lable.textColor = [UIColor whiteColor];
                }else if([[obj valueForKey:@"state"] integerValue]==2){
                    lable.backgroundColor = RGBACOLOR(186., 186., 186., 1);
                    lable.textColor = [UIColor whiteColor];
                }
            }
        }];
        
        [Calendercell addSubview:butten];
    }
    
}


-(void)buttenTouchUpInsideAction:(id)sender{
    NSInteger t = [sender tag]-301;
    dayArray = nil;
    dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];

    NSLog(@"%d年%d月%@日",strYear,strMonth,dayArray[t]);
    
}

//添加左右滑动手势
-(void)AddHandleSwipe{
    //声明和初始化手势识别器
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftHandleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightHandleSwipe:)];
    //对手势识别器进行属性设定
    [swipeLeft setNumberOfTouchesRequired:1];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setNumberOfTouchesRequired:1];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    //把手势识别器加到view中去
    [Calendercell addGestureRecognizer:swipeLeft];
    [Calendercell addGestureRecognizer:swipeRight];
}
//左滑事件
- (void)leftHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    strMonth = strMonth+1;
    if(strMonth == 13){
        strYear++;strMonth = 1;
    }
    [self reloadDateForCalendarWatch];
    
    [[Calendercell viewWithTag:3000] removeFromSuperview];
}
//右滑事件
- (void)rightHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
 
    strMonth = strMonth-1;
    if(strMonth == 0){
        strYear--;
        strMonth = 12;
    }
    [self reloadDateForCalendarWatch];
     [[Calendercell viewWithTag:3000] removeFromSuperview];   
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
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    Calendercell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
    [self setCell2View];
        return Calendercell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400.;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
