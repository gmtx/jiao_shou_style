//
//  RaiseMeViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-14.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "RaiseMeViewController.h"

@interface RaiseMeViewController ()

@end

@implementation RaiseMeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"养我";
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
    
    backPeopleImg = [[UIImageView alloc]initWithFrame:CGRectMake(VIEW_WEIGHT/2-60, 90, 120, 260)];
    backPeopleImg.backgroundColor = [UIColor redColor];
    [self.view addSubview:backPeopleImg];
    peopleImg = [[UIImageView alloc]initWithFrame:CGRectMake(VIEW_WEIGHT/2-50, 100, 100, 240)];
    peopleImg.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:peopleImg];
    
    
    self.slider = [[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20, VIEW_HEIGHT-120, VIEW_WEIGHT-40, 60)];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveSuffix:@""];
    self.slider.dataSource = self;
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
    [self.view addSubview:_slider];
    
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT/2-25, VIEW_HEIGHT-60, 50, 50);
    homeBtn.backgroundColor = [UIColor purpleColor];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];

}


#pragma mark - ASValueTrackingSliderDataSource

- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value;
{
    value = roundf(value);
    NSString *s;
    if (value <=30) {
        s = @"偏瘦";
        //图片变化
    } else if (value > 30.0 && value < 70.0) {
        s = @"适中";
    } else if (value >= 70.0) {
        s = @"偏胖";
    }
    return s;
}



-(void)HomeBtnPress
{
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:(index-1)] animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
