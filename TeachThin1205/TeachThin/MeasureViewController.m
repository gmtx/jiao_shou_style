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
-(void)viewWillDisappear:(BOOL)animated
{
    blueToothBtn.selected = NO;
    [self.manager stopScan];
    [self.manager cancelPeripheralConnection:self.peripheral];
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
    _nServices = [[NSMutableArray alloc]init];
    _nCharacteristics = [[NSMutableArray alloc]init];
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
    blueToothBtn.layer.cornerRadius = 30;
    [blueToothBtn setImage:[UIImage imageNamed:@"bluetoothClose"] forState:UIControlStateNormal];
    [blueToothBtn setImage:[UIImage imageNamed:@"bluetooth"] forState:UIControlStateSelected];
    [blueToothBtn addTarget:self action:@selector(BloothScan:) forControlEvents:UIControlEventTouchUpInside];
    blueToothBtn.selected = NO;
    [self.view addSubview:blueToothBtn];
    
    _InfotextView = [[UITextView alloc]initWithFrame:CGRectMake(10, VIEW_MAXY(blueToothBtn), VIEW_WEIGHT-20, 38)];
    _InfotextView.editable = NO;
    _InfotextView.textAlignment = NSTextAlignmentCenter;
    _InfotextView.font = [UIFont systemFontOfSize:12.];
    _InfotextView.textColor = [UIColor lightGrayColor];
    [self.view addSubview:_InfotextView];
    
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, VIEW_MAXY(blueToothBtn)+40, WIDTH_VIEW(self.view)-40, 30)];
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
    
    
    tf = [[UITextField alloc]initWithFrame:CGRectMake(10,0, WIDTH_VIEW(self.view)-60, 40)];
    tf.placeholder = @"请输入你的体重";
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.returnKeyType = UIReturnKeyDefault;
    tf.delegate = self;
    tf.userInteractionEnabled = YES;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [tf setInputAccessoryView:topView];
    
    
    tfv = [[UIView alloc]initWithFrame:CGRectMake(20,VIEW_MAXY(datelabel)-1, WIDTH_VIEW(self.view)-40, 40)];
    tfv.layer.borderColor=RGBACOLOR(190.0, 190.0, 190.0, 1).CGColor;
    tfv.layer.borderWidth = 1;
    [tfv addSubview:tf];
    
    
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(30, VIEW_MAXY(tfv)+40, WIDTH_VIEW(self.view)-60, 40);
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:label];
    [self.view addSubview:datelabel];
    [self.view addSubview:tfv];
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
//开始查看服务，蓝牙开启
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            //[self updateLog:@"蓝牙已打开,请扫描外设"];
            break;
        default:
            break;
    }
}

-(void)NetViewReloadData
{
    NSLog(@"________reload____________");
    [MBHUDView hudWithBody:@"加载中" type:MBAlertViewHUDTypeActivityIndicator hidesAfter:100000.0 show:YES];
}

-(void)BloothScan:(id)sender
{
    if(blueToothBtn.selected == NO){
        [self updateLog:@"正在扫描外设..."];
        blueToothBtn.selected = YES;
        NSArray *uuidArray = [NSArray arrayWithObjects:[CBUUID UUIDWithString:@"FFF0"],[CBUUID UUIDWithString:@"FFF4"],[CBUUID UUIDWithString:@"0221385A-9770-B192-B7E2-B55F888FD336"],nil];
        _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        [_manager scanForPeripheralsWithServices:uuidArray options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
        double delayInSeconds = 100000.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.manager stopScan];
            blueToothBtn.selected = NO;
            [self updateLog:@"扫描超时,停止扫描"];
        });
    }
}


-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"检查到外设方法");
    // [self updateLog:[NSString stringWithFormat:@"已发现 peripheral: %@ rssi: %@, UUID: %@ advertisementData: %@ ", peripheral, RSSI, peripheral.UUID, advertisementData]];
    _peripheral = peripheral;
    NSLog(@"%@",_peripheral);
    [self.manager connectPeripheral:_peripheral options:nil];
    //[self.manager stopScan];
}

//连接外设成功，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接外设成功，开始发现服务");
    [self updateLog:@"连接外设成功"];
    //[self updateLog:[NSString stringWithFormat:@"成功连接 peripheral: %@ with UUID: %@",peripheral,peripheral.UUID]];
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
    //[self updateLog:@"扫描服务"];
    
}
//连接外设失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%@连接外设失败",error);
}

//已发现服务
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    NSLog(@"已发现服务");
    [self updateLog:@"发现服务..."];
    int i=0;
    for (CBService *s in peripheral.services) {
        [self.nServices addObject:s];
    }
    for (CBService *s in peripheral.services) {
        //[self updateLog:[NSString stringWithFormat:@"%d :服务 UUID: %@(%@)",i,s.UUID.data,s.UUID]];
        i++;
        [peripheral discoverCharacteristics:nil forService:s];
    }
}


//已搜索到Characteristics
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    //[self updateLog:[NSString stringWithFormat:@"发现特征的服务:%@ (%@)",service.UUID.data ,service.UUID]];
    
    for (CBCharacteristic *c in service.characteristics) {
        NSLog(@"特征 UUID-----%@%@",c.UUID.data,c.UUID);
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]) {
            _writeCharacteristic = c;
        }
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF4"]]) {
            //[_peripheral readValueForCharacteristic:c];
            [_peripheral setNotifyValue:YES forCharacteristic:c];
        }
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"FFF5"]]) {
            [_peripheral readRSSI];
        }
        [_nCharacteristics addObject:c];
    }
}

//获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    // BOOL isSaveSuccess;
    NSLog(@"____%@__",characteristic.UUID);
    ;
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF4"]]) {
        NSLog(@"characteristic.value:%@",characteristic.value);
        _ResultData = [NSData dataWithData:characteristic.value];
        NSLog(@"__FFF4value_____%@",_ResultData);
        // _Resultlable.text = adata1;
        if(_ResultData.length>0&&!_Resultalert){
            _Resultalert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                      message:@"蓝牙体重秤想给您发送数据"
                                                     delegate:nil
                                            cancelButtonTitle:@"接受"
                                            otherButtonTitles:@"拒绝",nil];
            _Resultalert.delegate = self;
            [_Resultalert show];
            
        }
    }
    else{
    }
}



//中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"*********2************");
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    // Notification has started
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    } else { // Notification has stopped// so disconnect from the peripheral
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        //[self.manager cancelPeripheralConnection:self.peripheral];//断开连接
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if(alertView==_Resultalert){
        if(buttonIndex==0){
            NSLog(@"_____________OK______________%@",_ResultData);
            
            NSString *ResultStr = [NSString stringWithFormat:@"%@",(NSString *)[_ResultData subdataWithRange:NSMakeRange(1, 2)]];
            NSString *DWStr = (NSString *)[ResultStr substringWithRange:NSMakeRange(1, 2)];//单位(01B 为 KG,10B 为 LB,11B 为 ST)
            if([[DWStr substringToIndex:1] isEqualToString:@"4"]){
                _DWString = @"KG";
            }else if ([[DWStr substringToIndex:1] isEqualToString:@"8"]){
                _DWString = @"LB";
            }else if ([[DWStr substringToIndex:1] isEqualToString:@"c"]){
                _DWString = @"ST";
            }
            
            NSString *TZStr = (NSString *)[ResultStr substringWithRange:NSMakeRange(3, 2)];
            NSLog(@"截取%@^^^^^^^^^^^单位%@^^^^^^体重%@",ResultStr,DWStr,TZStr);
            
            float value = 16*[self TrasfomData:[TZStr substringToIndex:1]]+[self TrasfomData:[TZStr substringFromIndex:1]];
            //
            if([[ResultStr substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"0"]){
                _WeightValue = value/10;
            }else{
                int GaoNum = [[DWStr substringFromIndex:1] intValue];
                _WeightValue = (256*GaoNum+value)/10;
            }
            tf.text = [NSString stringWithFormat:@"%.1f%@",_WeightValue,_DWString];
        }
        
    }else{
        NSLog(@"______________Cancel_____________");
    }
    _Resultalert=nil;
}

-(int)TrasfomData:(NSString *)str
{
    int value = [str intValue];
    char c = [str characterAtIndex:0];
    switch (c) {
        case 'a':
            value = 10;
            break;
        case 'b':
            value = 11;
            break;
        case 'c':
            value = 12;
            break;
        case 'd':
            value = 13;
            break;
        case 'e':
            value = 14;
            break;
        case 'f':
            value = 15;
            break;
        default:
            break;
    }
    NSLog(@"value = %d",value);
    return value;
}

//textView更新
-(void)updateLog:(NSString *)s
{
    static unsigned int count = 0;
    [_InfotextView setText:[NSString stringWithFormat:@"[ %d ]  %@\r\n%@",count,s,_InfotextView.text]];
    count++;
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
