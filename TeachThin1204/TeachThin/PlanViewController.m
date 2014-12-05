//
//  PlanViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "PlanViewController.h"
#import "PlanDetailViewController.h"
#import "YiZhuViewController.h"

@interface PlanViewController ()

@end

@implementation PlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"百天计划";
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
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.PlanTag = 0;
    // Do any additional setup after loading the view.
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT/2-25, VIEW_HEIGHT-60, 50, 50);
    homeBtn.backgroundColor = [UIColor purpleColor];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    
    [self loadData];
}

-(void)HomeBtnPress{
    
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

-(void)setLayout
{
    int index=0;
    int n = _DataArr.count%2==0?_DataArr.count/2:(_DataArr.count/2+1);
    for(int i=0;i<n;i++){
        for(int j=0;j<2;j++){
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((VIEW_WEIGHT/2)*j+10, 90*i+80, VIEW_WEIGHT/2-15, 45)];
            [btn
             setBackgroundColor:RGBACOLOR(232., 235., 236., 0)];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15.];
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            btn.tag = index+100;
            [btn addTarget:self action:@selector(BtnPress:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.cornerRadius  =5.;
            btn.layer.borderWidth = 0.5;
            [self.view addSubview:btn];
            
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_VIEW(btn)-30, 0, 30, 20)];
            img.backgroundColor = [UIColor clearColor];
            img.image = [UIImage imageNamed:@"完成"];
            [btn addSubview:img];
            
            NSString *title = [[_DataArr objectAtIndex:index] valueForKey:@"title"];
            if([[[_DataArr objectAtIndex:index] valueForKey:@"state"] isEqualToString:@"0"]){
                title = [title stringByAppendingString:@"  正在执行"];
                img.hidden = YES;
            }else if([[[_DataArr objectAtIndex:index] valueForKey:@"state"] isEqualToString:@"1"]){
                title = [title stringByAppendingString:@"  已完成"];
            }
            [btn setTitle:title forState:UIControlStateNormal];
            index++;
            if(index==_DataArr.count){
                return;
            }
        }
    }

}

#pragma mark -
#pragma mark - Httprequest
-(void)loadData
{
    NSString *urlstr = URL_MyPlanStatus;
    NSDictionary *pragma = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"uid",nil];
    JSHttpRequest *request = [[JSHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:urlstr pragma:pragma ImageData:nil];
    request.successGetData = ^(id obj){
        //如果获取到数据网络页面消失
        [self removeNonetView];
        //加载框消失
        [MBHUDView dismissCurrentHUD];
        NSDictionary *dict = (NSDictionary *)obj;
        NSLog(@"DataDict-----%@",dict);
        _DataArr  = [NSArray arrayWithArray:[dict valueForKey:@"list"]];
        NSLog(@"__________DataArr%@",_DataArr);
        if(_DataArr.count>0){
            [self setLayout];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未制定任何计划" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
        }
    };
    request.failureGetData = ^(void){
        [self showNoNetView];//显示没有网络页面
        [MBHUDView dismissCurrentHUD];
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
    [self loadData];
}


-(void)BtnPress:(UIButton *)btn
{
    NSLog(@"%ld",(long)btn.tag);
    [self setSelectView];
    if(self.PlanTag==btn.tag){
        if(selectView.alpha==1){
            selectView.alpha = 0.;
        }else{
            selectView.alpha = 1.;
        }
    }else{
        self.PlanTag = btn.tag;
        selectView.alpha = 1;
        selectView.frame = CGRectMake(btn.frame.origin.x, VIEW_MAXY(btn), WIDTH_VIEW(btn), 40);
    }
    
}

-(void)SelectBtnPress:(UIButton *)btn
{
    if(btn.tag==0){
        YiZhuViewController *yizhuVC = [[YiZhuViewController alloc]init];
        yizhuVC.planId =[[_DataArr objectAtIndex:self.PlanTag-100] valueForKey:@"id"];
        [self.navigationController pushViewController:yizhuVC animated:YES];
    }else{
        PlanDetailViewController *detailVC = [[PlanDetailViewController alloc]init];
        detailVC.planId =[[_DataArr objectAtIndex:self.PlanTag-100] valueForKey:@"id"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}


-(void)setSelectView
{
    if(!selectView){
        selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT/2-15, 40)];
        selectView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:selectView];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 0,WIDTH_VIEW(selectView)/2-0.5, HEIGHT_VIEW(selectView));
        btn1.backgroundColor = RGBACOLOR(34., 34., 34., 1);
        [btn1 setTitle:@"医嘱" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(SelectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag = 0;
        [selectView addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(WIDTH_VIEW(selectView)/2, 0,WIDTH_VIEW(selectView)/2, HEIGHT_VIEW(selectView));
        btn2.backgroundColor = RGBACOLOR(34., 34., 34., 1);
        [btn2 setTitle:@"计划" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn2.tag = 1;
        [btn2 addTarget:self action:@selector(SelectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [selectView addSubview:btn2];
        [self.view addSubview:selectView];
        selectView.alpha = 0;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
