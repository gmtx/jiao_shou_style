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
    
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT-100, VIEW_WEIGHT, 15)];
    lineView.image = [UIImage imageNamed:@"colorLine"];
    [self.view addSubview:lineView];
    
    sliderSwich = [[UIImageView alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT-125, 30, 30)];
    sliderSwich.userInteractionEnabled = YES;
    sliderSwich.backgroundColor = [UIColor redColor];
    sliderSwich.layer.masksToBounds = YES;
    sliderSwich.layer.cornerRadius = 20.;
    [self.view addSubview:sliderSwich];
    //添加拖动手势
    //拖动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    [sliderSwich addGestureRecognizer:panGestureRecognizer];
    
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT/2-25, VIEW_HEIGHT-60, 50, 50);
    homeBtn.backgroundColor = [UIColor purpleColor];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];

}


//拖动手势响应事件
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    if(recognizer.view.center.x>0||recognizer.view.center.x<VIEW_WEIGHT){
        CGPoint translation = [recognizer translationInView:sliderSwich];
        recognizer.view.center = CGPointMake(recognizer.view.center.x+ translation.x,recognizer.view.center.y);
    }
    [recognizer setTranslation:CGPointZero inView:self.view];
    if(recognizer.state == UIGestureRecognizerStateEnded){
        //背景图做变化
    }
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
