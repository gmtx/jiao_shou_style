//
//  CalendarViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-26.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "CalendarViewController.h"
#import "Datetime.h"
@interface CalendarViewController ()
{
    NSArray * dayArray;
    
    int strMonth;
    int strYear;
    bool timePacker;
    
}

@end

@implementation CalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        strYear = [[Datetime GetYear:[NSDate date]] intValue];
        strMonth = [[Datetime GetMonth:[NSDate date]] intValue];
        dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
        timePacker = YES;
        
        self.title = @"量一量";
        
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
    //[self loadData];
    [self setlayout];
    [self.view setBackgroundColor:[UIColor whiteColor]];
 
    
}
-(void)loadData
{
    [MBHUDView hudWithBody:@"加载中" type:MBAlertViewHUDTypeActivityIndicator hidesAfter:100000.0 show:YES];
    NSString * uid = @"2";
    NSString * year = @"2014";
    NSString * month = @"4";
    
    NSString * url = URL_Measure_Inserm(uid, year, month);
 
    JSHttpRequest * request = [[JSHttpRequest alloc]init];
    [request StartWorkWithUrlstr:url];
    request.successGetData = ^(id obj){
        //如果获取到数据网络页面消失
        [self removeNonetView];
        //加载框消失
       NSLog(@"%@",obj);
        [MBHUDView dismissCurrentHUD];
        
        NSArray * dataArr = [obj valueForKey:@"result"];
        for (NSDictionary * dict in dataArr) {
            NSString * value2 = [dict valueForKey:@"weight"];
            if ([value2 isEqual:[NSNull null]]) {
                _noDataDay = [dict valueForKey:@"date"];
                
            }
        }
        
        
        
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




-(void)setlayout
{
    lable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH_VIEW(self.view)/2-10, 25)];
    lable1.text = @"补填";
    lable1.textAlignment = NSTextAlignmentLeft;
    lable1.textColor = [UIColor blackColor];
    lable1.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    
   
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH_VIEW(self.view), 25)];
    headerView.backgroundColor = [UIColor grayColor];
    [headerView addSubview:lable1];
    [headerView addSubview:[self CreatTitleView]];
    [self.view addSubview:headerView];
    
    
    [self CreatCalendarView];
    
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH_VIEW(self.view)-20, 40)];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    label2.textColor = [UIColor whiteColor];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"灰色表示未上传信息";
    
    
    footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, HEIGHT_VIEW(self.view)-40, WIDTH_VIEW(self.view), 40);
    footer.backgroundColor = [UIColor blackColor];
    [footer addSubview:label2];
    [self.view addSubview:footer];
    
}
-(void)CreatCalendarView
{
    [self AddHandleSwipe];
    
    NSMutableArray* weekarr = [[NSMutableArray alloc]initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    for (int i = 0; i < 7; i++) {
        UILabel* lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithString:weekarr[i]];
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = [UIColor clearColor];
        lable.frame = CGRectMake(i*45.7, 89,45.7, 26);
        lable.adjustsFontSizeToFitWidth = YES;
        lable.font = [UIFont systemFontOfSize:12.0f];
        lable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lable];
        
    }
    [self AddDaybuttenToCalendarWatch];
    
   
}
-(UIView*)CreatTitleView
{
    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_VIEW(self.view)/2, 0, WIDTH_VIEW(self.view)/2-10, 25)];
    titleview.backgroundColor = [UIColor clearColor];
    [titleview addSubview:[self CalendarTitleLabel]];
    titleview.tag = 3000;
    return titleview;
}

//制作阳历lable
-(UILabel *)CalendarTitleLabel{
    
    
    
    UILabel* calendarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 ,WIDTH_VIEW(self.view)/2-10, 25)];
    calendarTitleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    calendarTitleLabel.font = [UIFont boldSystemFontOfSize:14];  //设置文本字体与大小
    //titleLabel.textColor = [UIColor colorWithRed:(255.0/255.0) green:(255.0 / 255.0) blue:(255.0 / 255.0) alpha:1];  //设置文本颜色
    calendarTitleLabel.textColor = [UIColor blackColor];
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
    calendarTitleLabel.textAlignment = NSTextAlignmentRight;
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
    [headerView addSubview:[self CreatTitleView]];
    
    
    
}
-(void)reloadDaybuttenToCalendarWatch{
    for (int i = 0; i < 42; i++)
        [[self.view viewWithTag:301+i] removeFromSuperview];
    [self AddDaybuttenToCalendarWatch];
    
    
}
-(void)AddDaybuttenToCalendarWatch{
    
    for (int i = 0; i < 42; i++) {
        UIButton * butten = [[UIButton alloc]init];
        butten.frame = CGRectMake((i%7)*45.7, 115+(i/7)*40, 45.7, 40);
        [butten setTag:i+301];
        [butten addTarget:self action:@selector(buttenTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        butten.showsTouchWhenHighlighted = YES;
        
        UILabel * linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45.7, 1)];
        linelabel.backgroundColor = [UIColor grayColor];
        [butten addSubview:linelabel];
        
        
        
        UILabel* lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithString:dayArray[i]];
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = [UIColor clearColor];
        lable.frame = CGRectMake(7.5, 5, 30, 30);
        lable.adjustsFontSizeToFitWidth = YES;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.layer.masksToBounds = YES;
        lable.layer.cornerRadius = 15;
        [butten addSubview:lable];
        
        NSString* nodataYear = [_noDataDay substringToIndex:4];
        NSString*nodataMonth = [_noDataDay substringWithRange:NSMakeRange(5, 2)]  ;
        NSString*nodataDay = [_noDataDay substringFromIndex:8];
        
        
       
        if (([nodataDay intValue]==[dayArray[i] intValue])&&(strMonth==[nodataMonth intValue])&&(strYear== [nodataYear intValue]) ) {
            lable.backgroundColor = [UIColor grayColor];
            lable.textColor = [UIColor whiteColor];
        }
        
        
        if (([[Datetime GetDay:[NSDate date]] intValue]== [dayArray[i] intValue])&&(strMonth == [[Datetime GetMonth:[NSDate date]] intValue])&&(strYear == [[Datetime GetYear:[NSDate date]] intValue])) {
            lable.backgroundColor = RGBACOLOR(88, 155, 34, 1);
            lable.textColor = [UIColor whiteColor];
            lable.text = @"今天";
        }
        
        [self.view addSubview:butten];
        
        
    }
}
-(void)buttenTouchUpInsideAction:(id)sender{
    
   
    
    NSInteger t = [sender tag]-301;
    dayArray = nil;
    dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
    
    NSString * day = dayArray[t];
    if ([day integerValue]>[[Datetime GetDay:[NSDate date]] intValue]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您不能选择今天之后的日期" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }else if ([day integerValue]>0&&[day integerValue]<10) {
        _day =  [day substringFromIndex:2];
        _FillDate = [NSString stringWithFormat:@"%d-%d-%@",strYear,strMonth,_day];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"filldate" object:_FillDate];
        [self backBtnPress];
        
    }else if([day integerValue]>9&&[day integerValue]<100){
        _day =  [day substringFromIndex:0];
        _FillDate = [NSString stringWithFormat:@"%d-%d-%@",strYear,strMonth,_day];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"filldate" object:_FillDate];
        [self backBtnPress];

    }
    
  
    NSLog(@"%@",_FillDate);
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
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
}
//左滑事件
- (void)leftHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    strMonth = strMonth+1;
    if(strMonth == 13){
        strYear++;strMonth = 1;
    }
    [self reloadDateForCalendarWatch];
    
    [[self.view viewWithTag:3000] removeFromSuperview];
    
    
    
}
//右滑事件
- (void)rightHandleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    
    strMonth = strMonth-1;
    if(strMonth == 0){
        strYear--;
        strMonth = 12;
    }
    [self reloadDateForCalendarWatch];
    [[self.view viewWithTag:3000] removeFromSuperview];
    
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
