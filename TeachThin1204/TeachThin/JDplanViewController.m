//
//  JDplanViewController.m
//  TeachThin
//
//  Created by 王园园 on 14-11-28.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "JDplanViewController.h"


@interface JDplanViewController ()
{
    NSArray * dayArray;
    
    int strMonth;
    int strYear;
    bool timePacker;
    
}
@end

@implementation JDplanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        strYear = [[Datetime GetYear:[NSDate date]] intValue];
        strMonth = [[Datetime GetMonth:[NSDate date]] intValue];
        dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
        timePacker = YES;

        self.title = @"阶段计划";
        self.view.backgroundColor = [UIColor whiteColor];
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
    header = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH_VIEW(self.view), 37)];
    header.backgroundColor = RGBACOLOR(33., 41., 51., 1);
    
    UILabel *nowDatelable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, VIEW_WEIGHT-20, 37)];
    nowDatelable.textColor = [UIColor whiteColor];
    nowDatelable.font = [UIFont boldSystemFontOfSize:14.];
   
    NSString *Currentdate = [ManageVC DateStrFromDate:[NSDate date] Withformat:@"yyyy-MM-dd"];
    NSString *weekStr = [ManageVC getWeekday:[NSDate date]];

    nowDatelable.text = [NSString stringWithFormat:@"%@  %@",weekStr,Currentdate];
    [header addSubview:nowDatelable];
    [self.view addSubview:header];
    
    
    [self setCalenView];
    
    UIView *bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT-50, VIEW_WEIGHT, 50)];
    bottomview.backgroundColor = RGBACOLOR(22., 20., 20., 1);
    [self.view addSubview:bottomview];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 270, 30)];
    lable.backgroundColor = [UIColor clearColor];
    lable.text = @"绿色是按计划完成，红色是未按计划执行 灰色是为执行";
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont boldSystemFontOfSize:14.];
    lable.numberOfLines = 2;
    [lable sizeToFit];
    [bottomview addSubview:lable];
    
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT-60, VIEW_HEIGHT-100, 50, 50);
    homeBtn.backgroundColor = [UIColor purpleColor];
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
    NSString *urlstr = URL_JDPlanDetail;
    NSDictionary *pragma = [NSDictionary dictionaryWithObjectsAndKeys:_jieduanId,@"stageid",nil];
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
            _startDate = [[[_StatusArr objectAtIndex:0] firstObject] longLongValue];
            _startDate = [[[_StatusArr lastObject] firstObject] longLongValue];
            [self reloadDaybuttenToCalendarWatch] ;
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


-(void)setCalenView
{
    _CalenderView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, VIEW_WEIGHT, 400)];
    [self AddHandleSwipe];
    [self.view addSubview:_CalenderView];
    [_CalenderView addSubview:[self CreatTitleView]];
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
        [_CalenderView addSubview:lable];
        
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
    //titleLabel.textColor = [UIColor colorWithRed:(255.0/255.0) green:(255.0 / 255.0) blue:(255.0 / 255.0) alpha:1];  //设置文本颜色
    calendarTitleLabel.textColor = [UIColor lightGrayColor];
//    if ((strYear == [[Datetime GetYear] intValue])&&(strMonth ==[[Datetime GetMonth] intValue])){
//        calendarTitleLabel.text = [Datetime getDateTime];
//    }else {// }
    
    if (strMonth < 10) {
        calendarTitleLabel.text = [NSString stringWithFormat:@"%d年  %d月",strYear,strMonth];
    }else calendarTitleLabel.text = [NSString stringWithFormat:@"%d年%d月",strYear,strMonth];
   
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
    [_CalenderView addSubview:[self CreatTitleView]];  
}


-(void)reloadDaybuttenToCalendarWatch{
    for (int i = 0; i < 42; i++)
        [[_CalenderView viewWithTag:301+i] removeFromSuperview];
    [self AddDaybuttenToCalendarWatch];
    
    
}
-(void)AddDaybuttenToCalendarWatch{
    
    for (int i = 0; i < 42; i++) {
        UIButton * butten = [[UIButton alloc]init];
        butten.frame = CGRectMake((i%7)*45.7, 76+(i/7)*40, 45.7, 40);
        [butten setTag:i+301];
        [butten addTarget:self action:@selector(buttenTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        butten.showsTouchWhenHighlighted = YES;
        
        UILabel * linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45.7, 1)];
        linelabel.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [butten addSubview:linelabel];
        
        
        
        UILabel* lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithString:dayArray[i]];
        lable.textColor = RGBACOLOR(174., 174., 174., 1);
        lable.backgroundColor = [UIColor clearColor];
        lable.frame = CGRectMake(12, 7, 26, 26);
        lable.adjustsFontSizeToFitWidth = YES;
        lable.layer.cornerRadius = 11.8;
        lable.layer.masksToBounds = YES;
        [butten addSubview:lable];
        
        
        if (([[Datetime GetDay:[NSDate date]] intValue]== [dayArray[i] intValue])&&(strMonth == [[Datetime GetMonth:[NSDate date]] intValue])&&(strYear == [[Datetime GetYear:[NSDate date]] intValue])) {
            lable.backgroundColor = [UIColor blueColor];
            lable.textColor = [UIColor whiteColor];
        }
        //判断5个状态
        [_StatusArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[obj firstObject] longLongValue]];
            if(([[Datetime GetDay:date] intValue]== [dayArray[i] intValue])&&(strMonth == [[Datetime GetMonth:date] intValue])&&(strYear == [[Datetime GetYear:date] intValue])) {
                //1绿色已完成 0红色未完成2灰色点 3不可执行
                if([[obj lastObject] integerValue]==3){
                    lable.backgroundColor = [UIColor clearColor];
                    lable.textColor = [UIColor blackColor];//锁定到某天
                }else if([[obj lastObject] integerValue]==1){
                    lable.backgroundColor = RGBACOLOR(30., 153., 10, 1);
                    lable.textColor = [UIColor whiteColor];
                }else if([[obj lastObject] integerValue]==0){
                    lable.backgroundColor = RGBACOLOR(237., 38., 48., 1);
                    lable.textColor = [UIColor whiteColor];
                }else if([[obj lastObject] integerValue]==2){
                    lable.backgroundColor = RGBACOLOR(186., 186., 186., 1);
                    lable.textColor = [UIColor whiteColor];
                }
            }
            
                
            
        }];
        
        [_CalenderView addSubview:butten];    
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
    [_CalenderView addGestureRecognizer:swipeLeft];
    [_CalenderView addGestureRecognizer:swipeRight];
}
//左滑事件
- (void)leftHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    strMonth = strMonth+1;
    if(strMonth == 13){
        strYear++;strMonth = 1;
    }
    [self reloadDateForCalendarWatch];
    
    [[_CalenderView viewWithTag:3000] removeFromSuperview];
    
    
    
}
//右滑事件
- (void)rightHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    
    strMonth = strMonth-1;
    if(strMonth == 0){
        strYear--;
        strMonth = 12;
    }
    [self reloadDateForCalendarWatch];
    [[_CalenderView viewWithTag:3000] removeFromSuperview];
    
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
