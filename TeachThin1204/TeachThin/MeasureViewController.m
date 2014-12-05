//
//  MeasureViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-21.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "MeasureViewController.h"
#import "CalendarViewController.h"
#import "WeightTrendViewController.h"
#import "Config.h"
@interface MeasureViewController ()

@end

@implementation MeasureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
     
        self.title = @"量一量";
        Fill = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fill"] style:UIBarButtonItemStylePlain target:self action:@selector(FillClick:)];
        self.navigationItem.rightBarButtonItem = Fill;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arow"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnPress) ];
        self.navigationItem.leftBarButtonItem = backItem;
        
        
    }
    return self;
}
-(void)backBtnPress
{
    _showMenuView = NO;
    [menuView removeFromSuperview];
    
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:(index-1)] animated:YES];
    
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
    _showMenuView = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(datechange:) name:@"filldate" object:nil];
}
-(void)datechange:(NSNotification*)notification
{
    id obj = [notification object];
    _dateStr = [NSString stringWithFormat:@"%@",obj];
    datelabel.text = [NSString stringWithFormat:@"   %@",_dateStr];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [df setTimeZone:timeZone];
    [df setDateFormat:@"yyyy-MM-dd"];

    NSDate *gtmDate=[df dateFromString:_dateStr];
    NSTimeZone *localZone=[NSTimeZone localTimeZone];
    NSInteger interval=[localZone secondsFromGMTForDate:gtmDate];
    NSDate *date=[gtmDate dateByAddingTimeInterval:interval];
    
    
    
    _FillDate = [Config TimeToTimePr:date WithFormat:@"yyyy-MM-dd"];
      NSLog(@"**************%@",_FillDate);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getdate];
    [self setlayout];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Must be call in viewDidAppear
}
-(void)getdate
{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:nowDate];
    
    int nowYear = [comps year];
    int nowMonth = [comps month];
    int nowDay = [comps day];
  
    _dateStr = [NSString stringWithFormat:@"%d-%d-%d",nowYear,nowMonth,nowDay];
    NSLog(@"%@",_dateStr);
    _today = [Config TimeToTimePr:nowDate WithFormat:@"yyyy-MM-dd"];
    NSLog(@"^^^^^^^%@",_today);
    
}


-(void)setlayout
{
    blueToothBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    blueToothBtn.frame = CGRectMake(WIDTH_VIEW(self.view)/2-31, 84, 61, 61);
    blueToothBtn.backgroundColor = [UIColor blueColor];
    blueToothBtn.layer.cornerRadius = 30;
    blueToothBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluetooth"]];
    [self.view addSubview:blueToothBtn];
    
    
    
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, VIEW_MAXY(blueToothBtn), WIDTH_VIEW(self.view)-40, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"日期";
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size:16.0];
    label.textAlignment = NSTextAlignmentLeft;
    
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [topView setItems:buttonsArray];
    
    datelabel = [[UILabel alloc]initWithFrame:CGRectMake(20,VIEW_MAXY(label), WIDTH_VIEW(self.view)-40, 40)];
    datelabel.layer.borderWidth = 1;
    datelabel.layer.borderColor=RGBACOLOR(190.0, 190.0, 190.0, 1).CGColor;
    datelabel.text = [NSString stringWithFormat:@"   %@",_dateStr];
    
    
    tf = [[UITextField alloc]initWithFrame:CGRectMake(20,VIEW_MAXY(datelabel)-1, WIDTH_VIEW(self.view)-40, 40)];
    tf.layer.borderWidth = 1;
    tf.layer.borderColor = RGBACOLOR(190.0, 190.0, 190.0, 1).CGColor;
    tf.placeholder = @"   请输入你的体重";
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.returnKeyType = UIReturnKeyDefault;
    tf.delegate = self;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [tf setInputAccessoryView:topView];
   
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(30, VIEW_MAXY(tf)+40, WIDTH_VIEW(self.view)-60, 40);
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:label];
    [self.view addSubview:datelabel];
     [self.view addSubview:tf];
    [self.view addSubview:sureBtn];
    
    
}
//去掉输入的前后空格
-(NSString *)removespace:(UITextField *)textfield {
    return [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
-(void) dismissKeyBoard
{
    
    [tf resignFirstResponder];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [tf resignFirstResponder];
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [tf resignFirstResponder];
   
    return YES;
    
}
-(void)FillClick:(id)sender
{
    if (!_showMenuView) {
        _showMenuView = YES;
        menuView = [[MenuView alloc]initWithFrame:CGRectMake(WIDTH_VIEW(self.view)-130, 54, 120, 90)];
        menuView.backgroundColor = [UIColor clearColor];
        UIWindow * window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        [window addSubview:menuView];
        [menuView setUserInteractionEnabled:YES];
        [menuView setTapActionBlock:^(NSInteger Index) {
            switch (Index) {
                case 0:
                {
                    CalendarViewController * calendarVc = [[CalendarViewController alloc]init];
                    [self.navigationController pushViewController:calendarVc animated:YES];
                }
                    break;
                    case 1:
                {
                    WeightTrendViewController * wtVC = [[WeightTrendViewController alloc]init];
                    [self.navigationController pushViewController:wtVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }];
    }else
    {
        _showMenuView = NO;
        [menuView removeFromSuperview];
    }
    
   
    
}
//-(void)FillClick:(id)sender
//{
// 
//    
//    NSLog(@"Fill");
//    self.cas = [[CustomActionSheet alloc]initWithHeight:390 WithSheetTitle:@"请选择日期"];
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
//    rightButton.tintColor = RGBACOLOR(0, 94, 196, 1);
//    UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"上月" style:UIBarButtonItemStyleBordered target:self action:@selector(lastMonth)];
//    leftButton.tintColor = RGBACOLOR(0, 94, 196, 1);
//
//    UIBarButtonItem * nextButton = [[UIBarButtonItem alloc] initWithTitle:@"下月" style:UIBarButtonItemStyleBordered target:self action:@selector(nextMonth)];
//    
//    
//    UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    
//    
//    NSArray *array = [[NSArray alloc] initWithObjects:leftButton,nextButton, fixedButton,rightButton,nil];
//    [self.cas.toolbar setItems: array];
//    
//  
//    [self.cas addSubview:[self CreatTitleView]];
//    
//
//    
//    NSMutableArray* weekarr = [[NSMutableArray alloc]initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
//    for (int i = 0; i < 7; i++) {
//        UILabel* lable = [[UILabel alloc]init];
//        lable.text = [NSString stringWithString:weekarr[i]];
//        lable.textColor = [UIColor blackColor];
//        lable.backgroundColor = [UIColor clearColor];
//        lable.frame = CGRectMake(i*45.7, 40,45.7, 26);
//        lable.adjustsFontSizeToFitWidth = YES;
//        lable.font = [UIFont systemFontOfSize:12.0f];
//        lable.textAlignment = NSTextAlignmentCenter;
//        [self.cas addSubview:lable];
//    
//    }
//    [self AddDaybuttenToCalendarWatch];
//    [self.cas showFromRect:CGRectMake(0, HEIGHT_VIEW(self.view)-49, WIDTH_VIEW(self.view), 49) inView:self.view animated:YES];
//    
//    
//}
//-(UIView*)CreatTitleView
//{
//    UIView * titleview = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_VIEW(self.view)/2-40, 0, 80, 40)];
//    titleview.backgroundColor = [UIColor clearColor];
//    [titleview addSubview:[self CalendarTitleLabel]];
//    titleview.tag = 3000;
//    return titleview;
//}
//
//
//#pragma 自定义得弹出试图
////制作阳历lable
//-(UILabel *)CalendarTitleLabel{
//    UILabel* calendarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 ,80, 40)];
//    calendarTitleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
//    calendarTitleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
//    //titleLabel.textColor = [UIColor colorWithRed:(255.0/255.0) green:(255.0 / 255.0) blue:(255.0 / 255.0) alpha:1];  //设置文本颜色
//    calendarTitleLabel.textColor = [UIColor blackColor];
//    if ((strYear == [[Datetime GetYear] intValue])&&(strMonth ==[[Datetime GetMonth] intValue])){
//        calendarTitleLabel.text = [Datetime getDateTime];
//    }else {
//        if (strMonth < 10) {
//            calendarTitleLabel.text = [NSString stringWithFormat:@"%d年  %d月",strYear,strMonth];
//        }else calendarTitleLabel.text = [NSString stringWithFormat:@"%d年%d月",strYear,strMonth];
//    }
//    //设置标题
//    
//    //calendarTitleLabel.text = [Datetime getDateTime];  //设置标题
//    calendarTitleLabel.hidden = NO;
//    calendarTitleLabel.tag = 2001;
//    calendarTitleLabel.adjustsFontSizeToFitWidth = YES;
//    return calendarTitleLabel;
//}
//
//
//
//-(void)done
//{
//   
//    if(self.cas.OKBtnbloack){
//        self.cas.OKBtnbloack();
//    }
//    [self.cas dismissWithClickedButtonIndex:0 animated:YES];
//}
//
//-(void)lastMonth
//{
//    strMonth = strMonth-1;
//    if(strMonth == 0){
//        strYear--;strMonth = 12;
//    }
//    //NSLog(@"%d,%d",strYear,strMonth);
//    [self reloadDateForCalendarWatch];
//    [[self.cas viewWithTag:3000] removeFromSuperview];
//    
//  
//   
//
//}
//-(void)nextMonth
//{
//    strMonth = strMonth+1;
//    if(strMonth == 13){
//        strYear++;strMonth = 1;
//    }
//    //NSLog(@"%d,%d",strYear,strMonth);
//    [self reloadDateForCalendarWatch];
//    [[self.cas viewWithTag:3000] removeFromSuperview];
//    
//    
//}
////在CalendarWatch中重新部署数据
//-(void)reloadDateForCalendarWatch{
//    dayArray = nil;
//    dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
//    [self reloadDaybuttenToCalendarWatch];
//    [self.cas addSubview:[self CreatTitleView]];
//}
//-(void)reloadDaybuttenToCalendarWatch{
//    for (int i = 0; i < 42; i++)
//        [[self.cas viewWithTag:301+i] removeFromSuperview];
//    [self AddDaybuttenToCalendarWatch];
//}
//-(void)AddDaybuttenToCalendarWatch{
//    
//    for (int i = 0; i < 42; i++) {
//        UIButton * butten = [[UIButton alloc]init];
//        butten.frame = CGRectMake((i%7)*45.7, 76+(i/7)*40, 45.7, 40);
//        [butten setTag:i+301];
//        [butten addTarget:self action:@selector(buttenTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
//        butten.showsTouchWhenHighlighted = YES;
//        
//        UILabel * linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45.7, 1)];
//        linelabel.backgroundColor = [UIColor grayColor];
//        [butten addSubview:linelabel];
//        
//        
//        
//        UILabel* lable = [[UILabel alloc]init];
//        lable.text = [NSString stringWithString:dayArray[i]];
//        lable.textColor = [UIColor blackColor];
//        lable.backgroundColor = [UIColor clearColor];
//        lable.frame = CGRectMake(7.5, 5, 30, 30);
//        lable.adjustsFontSizeToFitWidth = YES;
//        lable.textAlignment = NSTextAlignmentCenter;
//        lable.layer.masksToBounds = YES;
//        lable.layer.cornerRadius = 15;
//        [butten addSubview:lable];
//        
//  
//        if (([[Datetime GetDay] intValue]== [dayArray[i] intValue])&&(strMonth == [[Datetime GetMonth] intValue])&&(strYear == [[Datetime GetYear] intValue])) {
//            lable.backgroundColor = [UIColor blueColor];
//            lable.textColor = [UIColor whiteColor];
//        }
//       
//            [self.cas addSubview:butten];
//      
//        
//    }
//}
//-(void)buttenTouchUpInsideAction:(id)sender{
//    NSInteger t = [sender tag]-301;
//    dayArray = nil;
//    dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
//    NSLog(@"%d年%d月%@日",strYear,strMonth,dayArray[t]);
//   
//}


-(void)sureBtnClick:(id)sender
{
//    NSLog(@"%@",tf.text);
//    WeightTrendViewController * wtvc = [[WeightTrendViewController alloc]init];
//    [self.navigationController pushViewController:wtvc animated:YES];
    if (!_FillDate) {
        NSString * uid = @"2";
        NSString * date = [NSString stringWithFormat:@"%@",_today];
        NSString * weight = @"50";
        NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",date,@"date",weight,@"weight" ,nil];
        NSLog(@"%@",postDict);
        
        
        NSString * url = URL_Measure_Data;
        JSHttpRequest * request = [[JSHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:url pragma:postDict ImageData:nil];
        request.successGetData = ^(id obj){
            //如果获取到数据网络页面消失
            [self removeNonetView];
            //加载框消失
            [MBHUDView dismissCurrentHUD];
            NSLog(@"*****%@",url);
            NSString * result = [obj valueForKey:@"code"];
            NSLog(@"^^^^^%@",result);
            if ([result isEqualToString:@"01"]) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的数据已经上传成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            
        };
        request.failureGetData = ^(void){
            [self showNoNetView];//显示没有网络页面
        };

    }else
    {
        NSString * uid = @"2";
        NSString * date = [NSString stringWithFormat:@"%@",_FillDate];
        NSString * weight = @"50";
        NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",date,@"date",weight,@"weight" ,nil];
        NSLog(@"%@",postDict);
        
        
        NSString * url = URL_Measure_Data;
        JSHttpRequest * request = [[JSHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:url pragma:postDict ImageData:nil];
        request.successGetData = ^(id obj){
            //如果获取到数据网络页面消失
            [self removeNonetView];
            //加载框消失
            [MBHUDView dismissCurrentHUD];
            NSLog(@"*****%@",url);
            NSString * result = [obj valueForKey:@"code"];
            NSLog(@"^^^^^%@",result);
            if ([result isEqualToString:@"01"]) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的数据已经上传成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            
        };
        request.failureGetData = ^(void){
            [self showNoNetView];//显示没有网络页面

        
    };
    }
    
    
    
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
