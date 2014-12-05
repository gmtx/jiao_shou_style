//
//  IntroduceViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-27.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "IntroduceViewController.h"
#import "LoginViewController.h"
@interface IntroduceViewController ()

@end

@implementation IntroduceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initGuide];
}
-(void)initGuide
{
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, CGRectGetHeight(self.view.frame))];
    [scrollView setContentSize:CGSizeMake(960, 0)];
    [scrollView setPagingEnabled:YES];
    [scrollView setBounces:NO];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    UIImageView *imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 320, CGRectGetHeight(scrollView.frame))];
    
    [imageview1 setImage:[UIImage imageNamed:@"introduce1"]];
    [scrollView addSubview:imageview1];
    
    UIImageView*imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(320, 0, 320, CGRectGetHeight(scrollView.bounds))];
    [imageview2 setImage:[UIImage imageNamed:@"introduce2"]];
    
    [scrollView addSubview:imageview2];
    
    UIImageView*imageview3=[[UIImageView alloc]initWithFrame:CGRectMake(640, 0, 320, CGRectGetHeight(scrollView.frame))];
    [imageview3 setImage:[UIImage imageNamed:@"introduce3"]];
    
    [scrollView addSubview:imageview3];
    
    imageview3.userInteractionEnabled=YES;
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(VIEW_WEIGHT/2-53, CGRectGetHeight(self.view.frame)-100, 106, 35)];
    [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    button.layer.borderColor = HexRGBAlpha(0xcce7f1, 1).CGColor;
    button.layer.borderWidth = 1.5f;
    button.layer.cornerRadius = 5.0f;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [imageview3 addSubview:button];
    
    UIPageControl*page=[[UIPageControl alloc]init];
    page.frame=CGRectMake(140, CGRectGetHeight(self.view.frame)-40, 45, 30);
    page.pageIndicatorTintColor = HexRGBAlpha(0x4fb4d9, 1);
    page.currentPageIndicatorTintColor = HexRGBAlpha(0xf2fbfb, 1);
    page.numberOfPages=3;
    page.currentPage=0;
    page.tag = 100;
    page.userInteractionEnabled=NO;
    [self.view addSubview:scrollView];
    [self.view addSubview:page];
    
}
//
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIPageControl* page = (UIPageControl*)[self.view viewWithTag:100];
    int current = scrollView.contentOffset.x/320;
    page.currentPage = current;
}

//点击进入体验按钮
-(void)firstpressed
{
    NSLog(@"tiyan");
//    ZRLoginViewController *loginVC = [[ZRLoginViewController alloc]init];
//    ZRAppDelegate *app = [UIApplication sharedApplication].delegate;
//    app.nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
//    app.nav.navigationBarHidden = YES;
//    self.view.window.rootViewController = app.nav;
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    UINavigationController * loginNc = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.view.window.rootViewController = loginNc;
  
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
