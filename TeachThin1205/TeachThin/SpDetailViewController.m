//
//  SpDetailViewController.m
//  TeachThin
//
//  Created by 王园园 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "SpDetailViewController.h"

@interface SpDetailViewController ()

@end

@implementation SpDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"运动详情";
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"喜欢" style:UIBarButtonItemStyleBordered target:self action:@selector(LoveBtnPress)];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backbtn"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnPress) ];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}
-(void)backBtnPress
{
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:(index-1)] animated:YES];
}
-(void)LoveBtnPress
{

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    }

-(void)HomeBtnPress{
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scroll];
    
    titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, VIEW_WEIGHT-20, 20)];
    titleLable.textColor = [UIColor blackColor];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.text = _titleStr;
    titleLable.font = [UIFont boldSystemFontOfSize:15.];
    titleLable.numberOfLines = 0;
    [titleLable sizeToFit];
    [scroll addSubview:titleLable];
    
    detailLable = [[UILabel alloc]initWithFrame:CGRectMake(10, VIEW_MAXY(titleLable)+5, VIEW_WEIGHT-20, 20)];
    detailLable.textColor = [UIColor grayColor];
    detailLable.textAlignment = NSTextAlignmentLeft;
    detailLable.text = _detailStr;
    detailLable.font = [UIFont systemFontOfSize:14.];
    detailLable.numberOfLines = 0;
    [detailLable sizeToFit];
    [scroll addSubview:detailLable];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, VIEW_MAXY(detailLable)+5, VIEW_WEIGHT, 1)];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    [scroll addSubview:line];
    
    webview = [[UIWebView alloc]initWithFrame:CGRectMake(10,VIEW_MAXY(line)+5, 300,0)];
    webview.backgroundColor = [UIColor clearColor];
    webview.opaque = NO;
    webview.dataDetectorTypes = UIDataDetectorTypeNone;

    NSString *webviewText = @"<style>body{margin:0;background-color:transparent;font:34px/48px Custom-Font-Name}</style>";
     //NSMutableString *oriStr = [[NSMutableString alloc]initWithString:_cotentStr];
    NSString *htmlString = [webviewText stringByAppendingFormat:@"%@",_cotentStr];
    [webview loadHTMLString:htmlString baseURL:nil]; //在 WebView 中显示本地的字符
    webview.scalesPageToFit = YES;
    webview.scrollView.bounces = NO;
    //_webView.userInteractionEnabled = NO;
    webview.delegate = self;
    [scroll addSubview:webview];
    NSString *height_str=  [webview stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int webViewHeight = [height_str intValue];
    webview.frame = CGRectMake(10,VIEW_MAXY(line)+10, VIEW_WEIGHT-10,webViewHeight);
    [scroll setContentSize:CGSizeMake(320, VIEW_MAXY(webview))];


    homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT/2-25, VIEW_HEIGHT-60, 50, 50);
    homeBtn.backgroundColor = [UIColor purpleColor];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];

}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    [scroll setContentSize:CGSizeMake(0, VIEW_MAXY(webview))];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
