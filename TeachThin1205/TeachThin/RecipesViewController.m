//
//  RecipesViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14/11/12.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import "RecipesViewController.h"
#import "MyPlanViewController.h"
@interface RecipesViewController ()

@end

@implementation RecipesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"每日食谱";
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
    
    [self loadData];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"uid"]);
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"uid"];
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    _arr = [[NSArray alloc]initWithObjects:@"早餐",@"早餐加餐",@"午餐",@"午餐加餐",@"晚餐", @"晚餐加餐", nil];
    NSLog(@"%@",_arr);
    [self getdate];
    [self setlayout];
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
    int nowWeek = [comps weekday];
    NSString *weekStr = [[NSString alloc] init];
    switch (nowWeek) {
        case 1:
            weekStr = @"星期天";
            break;
        case 2:
            weekStr = @"星期一";
            break;
        case 3:
            weekStr = @"星期二";
            break;
        case 4:
            weekStr = @"星期三";
            break;
        case 5:
            weekStr = @"星期四";
            break;
        case 6:
            weekStr = @"星期五";
            break;
        case 7:
            weekStr = @"星期六";
            break;
            
        default:
            break;
    }
   
    
    _datetime = [NSString stringWithFormat:@"%d-%d-%d",nowYear,nowMonth,nowDay];
    _weektime = [NSString stringWithFormat:@"%@",weekStr];
   
    
}
-(void)loadData
{
    [MBHUDView hudWithBody:@"加载中" type:MBAlertViewHUDTypeActivityIndicator hidesAfter:100000.0 show:YES];
    NSString * uid = @"1";
    NSString * date = @"2014-12-1";
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",date,@"date",nil];
    NSLog(@"%@",postDict);
    NSString * url = URL_Recipes_recipes;
     NSLog(@"*****%@",url);
    JSHttpRequest * request = [[JSHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:url pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        //如果获取到数据网络页面消失
        [self removeNonetView];
        //加载框消失
        [MBHUDView dismissCurrentHUD];
        NSLog(@"^^^^^^^%@",obj);
       // _dict = [obj valueForKey:@"data"];
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
    [self loadData];
    [MBHUDView hudWithBody:@"加载中" type:MBAlertViewHUDTypeActivityIndicator hidesAfter:100000.0 show:YES];
    
}





-(void)setlayout
{
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view)/4, 35)];
    label1.backgroundColor = [UIColor clearColor];
    if(_weektime!=nil){
        label1.text = [NSString stringWithFormat:@"%@",_weektime];
    }
    label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    
    UIImageView * btnimgv = [[UIImageView alloc]init];
    btnimgv.frame = CGRectMake(140, 15, 9, 5);
    btnimgv.image = [UIImage imageNamed:@"arrow"];
    
    
    dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dateBtn.frame = CGRectMake(VIEW_MAXX(label1), 0, WIDTH_VIEW(self.view)/2, 35);
    dateBtn.backgroundColor = [UIColor clearColor];
    [dateBtn setTitle:_datetime forState:UIControlStateNormal];
    dateBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    [dateBtn addTarget:self action:@selector(dateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [dateBtn addSubview:btnimgv];
    
    
    header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 35)];
    header.backgroundColor = RGBACOLOR(34, 42, 51, 1);
    header.tag = 3000;
    [header addSubview:label1];
    [header addSubview:dateBtn];
    
    

    
    
    planBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    planBtn.frame = CGRectMake(WIDTH_VIEW(self.view)*1.5/8, 40, 73, 73);
   
    planBtn.layer.cornerRadius = 36.5;
    [planBtn addTarget:self action:@selector(PlanClick:) forControlEvents:UIControlEventTouchUpInside];
    planBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"plan"]];

    
    noplanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    noplanBtn.frame = CGRectMake(WIDTH_VIEW(self.view)*4.6/8, 40, 73, 73);
    
    noplanBtn.layer.cornerRadius = 36.5;
    [noplanBtn addTarget:self action:@selector(noPlanClick:) forControlEvents:UIControlEventTouchUpInside];
    noplanBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"noplan"]];
 
    
    footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 160)];
    footer.backgroundColor = RGBACOLOR(235, 235, 241, 1);
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(WIDTH_VIEW(footer)-70, HEIGHT_VIEW(footer)-60, 56, 56);
    homeBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBtn"]];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:homeBtn];
    

    [footer addSubview:planBtn];
    [footer addSubview:noplanBtn];
    
    
    if (!table) {
        table = [[UITableView alloc]initWithFrame:CGRectMake(0, VIEW_oringeY, WIDTH_VIEW(self.view), HEIGHT_VIEW(self.view)-VIEW_oringeY) style:UITableViewStyleGrouped];
        table.delegate = self;
        table.dataSource = self;
        table.tableHeaderView = header;
        table.tableFooterView = footer;
        [self.view addSubview:table];
    }
    

  
    
}


-(void)HomeBtnPress
{
    
   NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
   [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:(index-1)] animated:YES];
}


#pragma table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = (UITableViewCell *)[self tableView:table cellForRowAtIndexPath:indexPath];
    UILabel *lable = (UILabel *)[cell viewWithTag:1000];
    if (HEIGHT_VIEW(lable)<36) {
        return 56;
    }
    return HEIGHT_VIEW(lable)+20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [_arr count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell * cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
       
        _celltitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH_VIEW(cell.contentView)/4, 36)];
        _celltitle.textAlignment = NSTextAlignmentLeft;
        _celltitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];

        _celltitle.textColor = [UIColor blackColor];
        [cell.contentView addSubview:_celltitle];
        
        _cellcontent = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_MAXX(_celltitle)+20, 10, WIDTH_VIEW(cell.contentView)*5/8-20, 36)];
       
        _cellcontent.backgroundColor = [UIColor clearColor];
        _cellcontent.textAlignment = NSTextAlignmentLeft;
        _cellcontent.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        [_cellcontent setLineBreakMode:NSLineBreakByWordWrapping];
        [_cellcontent setNumberOfLines:0];
        _cellcontent.tag = 1000;
        [cell.contentView addSubview:_cellcontent];
        
        
        
    }
    _celltitle.text = [_arr objectAtIndex:indexPath.section];
    switch (indexPath.section) {
        case 0:
        {
            
                _cellcontent.text = [_dict valueForKey:@"breakfast"];
            
            
        }
            break;
            case 1:
        {
           
                _cellcontent.text = [_dict valueForKey:@"breakfastadd"];
           
           
        }
            break;
            case 2:
        {
            
                 _cellcontent.text = [_dict valueForKey:@"lunch"];
           
        }
            break;
            case 3:
        {
           
           _cellcontent.text = [_dict valueForKey:@"lunchadd"];
           
        }
            break;
            case 4:
        {
          
                _cellcontent.text = [_dict valueForKey:@"dinner"];
           
        }
            break;
            case 5:
        {
           
                 _cellcontent.text = [_dict valueForKey:@"dinneradd"];
         
        }
            break;
        default:
            break;
    }
    

    return cell;
}
-(void)dateBtnClick:(id)sender
{
    NSLog(@"date");
    self.cas = [[CustomActionSheet alloc]initWithHeight:250 WithSheetTitle:@"请选择日期"];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    
    rightButton.tintColor = RGBACOLOR(0, 94, 196, 1);
    UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(docancel)];
    leftButton.tintColor = RGBACOLOR(0, 94, 196, 1);
    
    
    UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    NSArray *array = [[NSArray alloc] initWithObjects:leftButton,fixedButton,rightButton,nil];
    
    [self.cas.toolbar setItems: array];
    
    self.dp = [[UIDatePicker alloc]init];
    self.dp.datePickerMode =  UIDatePickerModeDate;
    self.dp.bounds = CGRectMake(0, 0, WIDTH_VIEW(self.view), 100);
    
    [self.dp addTarget:self action:@selector(datechange) forControlEvents:UIControlEventValueChanged];
    [self.cas addSubview:self.dp];
    
    [self.cas showFromRect:CGRectMake(0, HEIGHT_VIEW(self.view)-49, WIDTH_VIEW(self.view), 49) inView:self.view animated:YES];
    
    
}




#pragma 自定义得datepicker
-(void)done

{
    if(self.cas.OKBtnbloack){
        self.cas.OKBtnbloack();
    }
    [self.cas dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)docancel

{
    [self.cas dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)datechange
{
    NSDate *selectedDate = [self.dp date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [formatter stringFromDate:selectedDate];
    
    NSLog(@"%@",dateString);
   
    
    _Showdate = selectedDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:_Showdate];
    
    int nowYear = [comps year];
    int nowMonth = [comps month];
    int nowDay = [comps day];
    int nowWeek = [comps weekday];
    NSString *weekStr = [[NSString alloc] init];
    switch (nowWeek) {
        case 1:
            weekStr = @"星期天";
            break;
        case 2:
            weekStr = @"星期一";
            break;
        case 3:
            weekStr = @"星期二";
            break;
        case 4:
            weekStr = @"星期三";
            break;
        case 5:
            weekStr = @"星期四";
            break;
        case 6:
            weekStr = @"星期五";
            break;
        case 7:
            weekStr = @"星期六";
            break;
            
        default:
            break;
    }
    
    
    _datetime1 = [NSString stringWithFormat:@"%d-%d-%d",nowYear,nowMonth,nowDay];
    _weektime1 = [NSString stringWithFormat:@"%@",weekStr];
    NSLog(@"^^^^^^^^^%@",_datetime1);
    NSLog(@"^^^^^^^^%@",_weektime1);
    label1.text = [NSString stringWithFormat:@"%@",_weektime1];
    [dateBtn setTitle:_datetime1 forState:UIControlStateNormal];
    
    
    
    [table reloadData];
    
    
    
    
    
}

-(void)PlanClick:(id)sender
{
    NSLog(@"提交食谱");
    
    [MBHUDView hudWithBody:@"加载中" type:MBAlertViewHUDTypeActivityIndicator hidesAfter:100000.0 show:YES];
    NSString * uid = @"1";
    NSString * date = @"2014-12-1";
    NSString * plan = @"1";
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",date,@"date",plan,@"plan",nil];
    NSLog(@"%@",postDict);
    NSString * url = URL_Recipes_plan;
    NSLog(@"*****%@",url);
    JSHttpRequest * request = [[JSHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:url pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        //如果获取到数据网络页面消失
        [self removeNonetView];
        //加载框消失
        [MBHUDView dismissCurrentHUD];
        NSLog(@"^^^^^%@",obj);
        NSInteger result =[[obj valueForKey:@"code"]integerValue] ;
        if (result==201) {
            UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的数据已经提交成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    };
    request.failureGetData = ^(void){
        [MBHUDView dismissCurrentHUD];
        [self showNoNetView];//显示没有网络页面
    };
    
    
    
    
    
}
-(void)noPlanClick:(id)sender
{
    MyPlanViewController * mpvc = [[MyPlanViewController alloc]init];
    mpvc.datetime = [NSString stringWithFormat:@"%@",_datetime];
    [self.navigationController pushViewController:mpvc animated:YES];
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
