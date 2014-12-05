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
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT-0) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT-60, VIEW_WEIGHT, 60)];
    footView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:footView];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(15,10, VIEW_WEIGHT-20, 20)];
    lable1.textColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
    NSMutableAttributedString * str2 = [[NSMutableAttributedString alloc]initWithString:@"完成的用绿色 未完成的用红色 "];
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(4,2)];
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(12,2)];
    lable1.attributedText = str2 ;
    lable1.backgroundColor = [UIColor clearColor];
    lable1.textAlignment = NSTextAlignmentLeft;
    lable1.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    [footView addSubview:lable1];
    
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(15,30, VIEW_WEIGHT-20, 20)];
    lable2.textColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
    lable2.backgroundColor = [UIColor clearColor];
    lable2.textAlignment = NSTextAlignmentLeft;
    lable2.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    lable2.text = @"现在体重：90kg 减肥：60kg 目标体重：50kg";
    [footView addSubview:lable2];
}

-(void)setCell2View
{
    
    
    Calendercell.frame = CGRectMake(0, 0, VIEW_WEIGHT, 310);
    Calendercell.backgroundColor = GXRandomColor;
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
    
    for (int i = 0; i < 42; i++) {
        UIButton * butten = [[UIButton alloc]init];
        butten.frame = CGRectMake((i%7)*45.7, 76+(i/7)*40, 45.7, 40);
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
        
        
        if (([[Datetime GetDay:[NSDate date]] intValue]== [dayArray[i] intValue])&&(strMonth == [[Datetime GetMonth:[NSDate date]] intValue])&&(strYear == [[Datetime GetYear:[NSDate date]] intValue])) {
            lable.backgroundColor = [UIColor blueColor];
            lable.textColor = [UIColor whiteColor];
        }
        
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
    
    return 2;
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
    if(indexPath.section==0){
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 55, 55)];
        img.backgroundColor = [UIColor yellowColor];
        img.layer.cornerRadius = 25.;
        [cell.contentView addSubview:img];
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, VIEW_WEIGHT-30, 20)];
        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        titleLable.text = @"刘小小";
        [cell.contentView addSubview:titleLable];
        
        UILabel *phoneLable = [[UILabel alloc]initWithFrame:CGRectMake(80, VIEW_MAXY(titleLable)+5, VIEW_WEIGHT-30, 20)];
        phoneLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        phoneLable.backgroundColor = [UIColor clearColor];
        phoneLable.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
        phoneLable.text = @"刘小小";
        [cell.contentView addSubview:phoneLable];
        return cell;
    }else{
        Calendercell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
        [self setCell2View];
        return Calendercell;
    }
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        return 80;
    }else{
        return 400;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, 30)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    if(section==1){
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        lable.text = @"  百天计划";
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = [UIColor clearColor];
        [view addSubview:lable];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(VIEW_WEIGHT-50, 0, 50,30)];
        img.backgroundColor = [UIColor redColor];
        [view addSubview:img];
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return 0.;
    }else{
        return 30.;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
