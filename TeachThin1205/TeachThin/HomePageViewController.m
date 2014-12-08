//
//  HomePageViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "HomePageViewController.h"
#import "RecipesViewController.h"
#import "MeViewController.h"
#import "ShopViewController.h"
#import "MeasureViewController.h"
#import "SportsViewController.h"
#import "PhotoViewController.h"
#import "YingyangViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"教●瘦";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setlayout];
    
}
-(void)setlayout
{
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(WIDTH_VIEW(self.view)/32, VIEW_oringeY+20, WIDTH_VIEW(self.view)*13/32, 80);
    btn1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hp1"]];
    [btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(VIEW_MAXX(btn1)+WIDTH_VIEW(self.view)/64, VIEW_oringeY+20, WIDTH_VIEW(self.view)/4,WIDTH_VIEW(self.view)/4);
    btn2.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"hp2"]];
    [btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(VIEW_MAXX(btn2)+WIDTH_VIEW(self.view)/64, VIEW_oringeY+20, WIDTH_VIEW(self.view)/4,WIDTH_VIEW(self.view)/4);
    btn3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hp3"]];
    [btn3 addTarget:self action:@selector(btn3Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(WIDTH_VIEW(self.view)/32, VIEW_MAXY(btn1)+HEIGHT_VIEW(self.view)/48, WIDTH_VIEW(self.view)*43/64, 100);
    btn4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hp4"]];
    [btn4 addTarget:self action:@selector(btn4Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(VIEW_MAXX(btn4)+WIDTH_VIEW(self.view)/64, VIEW_MAXY(btn3)+HEIGHT_VIEW(self.view)/48, WIDTH_VIEW(self.view)/4, 100);
    btn5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hp5"]];
    [btn5 addTarget:self action:@selector(btn5Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.frame = CGRectMake(WIDTH_VIEW(self.view)/32, VIEW_MAXY(btn4)+HEIGHT_VIEW(self.view)/48, WIDTH_VIEW(self.view)*13/32, 83);
    btn6.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"hp6"]];
    [btn6 addTarget:self action:@selector(btn6Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];
    
    btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn7.frame = CGRectMake(VIEW_MAXX(btn6)+WIDTH_VIEW(self.view)/64, VIEW_MAXY(btn4)+HEIGHT_VIEW(self.view)/48, WIDTH_VIEW(self.view)/4, 83);
    btn7.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"hp7"]];
    [btn7 addTarget:self action:@selector(btn7Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn7];
    
    btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn8.frame = CGRectMake(VIEW_MAXX(btn7)+WIDTH_VIEW(self.view)/64,VIEW_MAXY(btn4)+HEIGHT_VIEW(self.view)/48, WIDTH_VIEW(self.view)/4, 83);
    btn8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hp8"]];
    [btn8 addTarget:self action:@selector(btn8Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn8];
    
    btn9 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn9.frame = CGRectMake(WIDTH_VIEW(self.view)/32, VIEW_MAXY(btn6)+HEIGHT_VIEW(self.view)/48, WIDTH_VIEW(self.view)*13/32, 83);
    btn9.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hp9"]];
    [btn9 addTarget:self action:@selector(btn9Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn9];
    
//    btn10 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn10.frame = CGRectMake(VIEW_MAXX(btn9)+WIDTH_VIEW(self.view)/64, VIEW_MAXY(btn6)+HEIGHT_VIEW(self.view)/48, WIDTH_VIEW(self.view)*25/48, HEIGHT_VIEW(self.view)/6);
//    btn10.backgroundColor = GXRandomColor;
//    [btn10 addTarget:self action:@selector(btn10Click:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn10];
}
-(void)btn1Click:(id)sender
{
    NSLog(@"每日食谱");
    RecipesViewController * recipesVC = [[RecipesViewController alloc]init];
    [self.navigationController pushViewController:recipesVC animated:YES];
}
-(void)btn2Click:(id)sender
{
    NSLog(@"拍一拍");
    PhotoViewController *phoneVC = [[PhotoViewController alloc]init];
    [self.navigationController pushViewController:phoneVC animated:YES];
    
    
}
-(void)btn3Click:(id)sender
{
    NSLog(@"每日运动");
    SportsViewController *sportVC = [[SportsViewController alloc]init];
    [self.navigationController pushViewController:sportVC animated:YES];
    
}
-(void)btn4Click:(id)sender
{
    NSLog(@"我");
    MeViewController * meVC = [[MeViewController alloc]init];
    [self.navigationController pushViewController:meVC animated:YES];
}
-(void)btn5Click:(id)sender
{
    NSLog(@"找专家");
}
-(void)btn6Click:(id)sender
{
    NSLog(@"加好友");
}
-(void)btn7Click:(id)sender
{
    NSLog(@"营养知识");
    YingyangViewController * yyvc = [[YingyangViewController alloc]init];
    [self.navigationController pushViewController:yyvc animated:YES];
}
-(void)btn8Click:(id)sender
{
    NSLog(@"量一量");
    MeasureViewController * measureVC = [[MeasureViewController alloc]init];
    [self.navigationController pushViewController:measureVC animated:YES];
    
    
}
-(void)btn9Click:(id)sender
{
    NSLog(@"食物配送");
    ShopViewController * shopVC = [[ShopViewController alloc]init];
    [self.navigationController pushViewController:shopVC animated:YES];
}
-(void)btn10Click:(id)sender
{
    NSLog(@"设置");
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
