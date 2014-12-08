//
//  CompareViewController.m
//  TeachThin
//
//  Created by 王园园 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "CompareViewController.h"
#import "PhotoMoreViewController.h"

@interface CompareViewController ()

@end

@implementation CompareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"食物对比";
        self.view.backgroundColor = RGBACOLOR(235., 235., 241., 1);
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _Listpage = 0;
    _ListDataArr = [[NSMutableArray alloc]init];
    
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, 140)];
    selfImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, VIEW_WEIGHT/2-17, 90)];
    selfImgView.backgroundColor = [UIColor yellowColor];
    [headView addSubview:selfImgView];
    TukuImgView = [[UIImageView alloc]initWithFrame:CGRectMake(VIEW_WEIGHT/2+5, 10, VIEW_WEIGHT/2-17, 90)];
    TukuImgView.backgroundColor = [UIColor yellowColor];
    [headView addSubview:TukuImgView];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, VIEW_MAXY(selfImgView)+5, VIEW_WEIGHT/2-20, 30)];
    lable.text = @"拍摄图片";
    lable.font = [UIFont systemFontOfSize:14.];
    lable.textColor = [UIColor darkGrayColor];
    [headView addSubview:lable];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_WEIGHT/2+13, VIEW_MAXY(selfImgView)+5, VIEW_WEIGHT/2-20, 30)];
    lable1.text = @"图库图片";
    lable1.font = [UIFont systemFontOfSize:14.];
    lable1.textColor = [UIColor darkGrayColor];
    [headView addSubview:lable1];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    table.tableHeaderView = headView;
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT-70, VIEW_HEIGHT-60, 50, 50);
    [homeBtn setImage:[UIImage imageNamed:@"homeBtn"] forState:UIControlStateNormal];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
//    if(_Foodtype==1){
//        [self addFooter];
//    }
}

-(void)HomeBtnPress{
    
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    selfImgView.image = _selfImg;
    if(!_DataDict){
       [self loadData];
    }
}

#pragma mark -
#pragma mark - Httprequest
-(void)loadData
{
    NSString *urlstr = URL_PhotoData(_Foodname);
    NSLog(@"++++++++++++++%@",urlstr);
    JSHttpRequest *request = [[JSHttpRequest alloc]init];
    [request StartWorkWithUrlstr:urlstr];
    request.successGetData = ^(id obj){
        //如果获取到数据网络页面消失
        [self removeNonetView];
        //加载框消失
        [MBHUDView dismissCurrentHUD];
        NSDictionary *dict = (NSDictionary *)obj;
        if([[dict valueForKey:@"code"]isEqualToString:@"01"]){
            _DataDict = [dict valueForKey:@"result"];
            //更改图库图片
            //TukuImgView.image = [];
            NSLog(@"DataDict-----%@",_DataDict);
            if(_Foodtype==1){
                _DanpinId = [_DataDict valueForKey:@"id"];
            }
            [table reloadData];
        }
    };
    request.failureGetData = ^(void){
        [MBHUDView dismissCurrentHUD];
        [self showNoNetView];//显示没有网络页面
    };
}

-(void)loadJiaohuanfenData
{
    NSString *urlstr = URL_JiaohuanfenData(_DanpinId,@(_Listpage));
    NSLog(@"jiaohuanfen++++++++%@",urlstr);
    JSHttpRequest *request = [[JSHttpRequest alloc]init];
    [request StartWorkWithUrlstr:urlstr];
    request.successGetData = ^(id obj){
        //如果获取到数据网络页面消失
        //[self removeNonetView];
        //加载框消失
        //[MBHUDView dismissCurrentHUD];
        NSDictionary *Dict = (NSDictionary *)obj;
        NSLog(@"DataDict-----%@",Dict);
        if(![[Dict valueForKey:@"result"] isEqual:[NSNull null]]){
            NSArray *listArr = [NSArray arrayWithArray:[Dict valueForKey:@"result"]];
            if(listArr.count>0){
                _Listpage++;
                [_ListDataArr addObjectsFromArray:listArr];
                NSLog(@"ListDataArr____________________%@",_ListDataArr);
                [table reloadData];
            }
        }
    };
    request.failureGetData = ^(void){
        //[self showNoNetView];//显示没有网络页面
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
    [self loadData];
}




#pragma mark - UItableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if(section==0){
        return 5;
    }else{
        return _ListDataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSArray *titleArr = @[@"对比结果",@"能量(kacl)",@"蛋白质(g)",@"脂肪(g)",@"碳水化合物(g)"];
    NSArray *KeyArr = @[@"foodname",@"energy",@"protein",@"fat",@"carbodydrates "];
    UITableViewCell *cell;
    UILabel *titleLable;
    UILabel *detaillable;
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 7, 110, 30)];
        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [cell.contentView addSubview:titleLable];
        
        detaillable = [[UILabel alloc]initWithFrame:CGRectMake(130,12, VIEW_WEIGHT-120, 30)];
        detaillable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        detaillable.backgroundColor = [UIColor clearColor];
        detaillable.textColor =[[UIColor grayColor] colorWithAlphaComponent:0.8];
        [cell.contentView addSubview:detaillable];
        
        if(indexPath.section==0&&indexPath.row==0&&_Foodtype==1){
            UIButton *freshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            freshBtn.frame = CGRectMake(VIEW_WEIGHT-60, 0, 45, 45);
            [freshBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            [freshBtn setImage:[UIImage imageNamed:@"OpenImg"] forState:UIControlStateNormal];
            freshBtn.backgroundColor = [UIColor clearColor];
            [freshBtn addTarget:self action:@selector(freshBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:freshBtn];
        }else if (indexPath.section==1){
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_WEIGHT/2, 0, 0.5, 30)];
            line.backgroundColor = RGBACOLOR(208., 208., 208., 1);
            [cell addSubview:line];
        }
    }
    if(indexPath.section==0){
        titleLable.text = titleArr[indexPath.row];
        NSString *detailStr = [_DataDict valueForKey:KeyArr[indexPath.row]];
        if(detailStr.length==0){
            detaillable.text = @"0";
        }else{
            detaillable.text = detailStr;
        }
        detaillable.numberOfLines = 0;
        [detaillable sizeToFit];
    }else if(indexPath.section==1){
        //titleLable.frame = CGRectMake(20, 0, VIEW_WEIGHT/2-20, 30);
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:13.];
        titleLable.text = [[_ListDataArr objectAtIndex:indexPath.row] valueForKey:@"name"];
        
        detaillable.frame = CGRectMake(VIEW_WEIGHT/2, 0, VIEW_WEIGHT/2-10, 30);
        detaillable.textAlignment = NSTextAlignmentCenter;
        detaillable.font = [UIFont systemFontOfSize:13.];
        detaillable.text = [[_ListDataArr objectAtIndex:indexPath.row] valueForKey:@"kg"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        return 40.;
    }else{
        return 30;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    
    if(section==0){
        view.backgroundColor = RGBACOLOR(235., 235., 241., 1);
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.frame = CGRectMake(0, 0, VIEW_WEIGHT, 35);
        [moreBtn setBackgroundColor:RGBACOLOR(34., 42., 51., 1)];
        [moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [moreBtn setTitle:@" 查看更多" forState:UIControlStateNormal];
        moreBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        moreBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.];
        [moreBtn addTarget:self action:@selector(MoreBtnPresss:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:moreBtn];
        
        if(_ListDataArr.count>=1){
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, VIEW_WEIGHT/2, 30)];
            lable.backgroundColor = RGBACOLOR(167., 167., 167.,1);
            lable.font = [UIFont boldSystemFontOfSize:14.];
            lable.text = @"食品";
            lable.textAlignment = NSTextAlignmentCenter;
            lable.textColor = [UIColor whiteColor];
            [view addSubview:lable];
        
            UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_WEIGHT/2, 55, VIEW_WEIGHT/2, 30)];
            lable2.backgroundColor = RGBACOLOR(167., 167., 167.,1);
            lable2.font = [UIFont boldSystemFontOfSize:14.];
            lable2.text = @"重量";
            lable2.textAlignment = NSTextAlignmentCenter;
            lable2.textColor = [UIColor whiteColor];
            [view addSubview:lable2];
        }
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==0){
        return 85;
    }else{
        return 0.5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}

-(void)MoreBtnPresss:(UIButton *)btn
{
    PhotoMoreViewController *moreVC = [[PhotoMoreViewController alloc] init];
    moreVC.Datadict = _DataDict;
    [self.navigationController pushViewController:moreVC animated:YES];
}
-(void)freshBtnPress:(UIButton *)btn
{
    if(_DanpinId>0&&_ListDataArr.count==0){//必须获取到单品的ID
        _Listpage=1;
        NSLog(@"____________________");
        [self loadJiaohuanfenData];
    }
    [self addFooter];
}


- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = table;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        [self loadJiaohuanfenData];
        //_CellCount +=6;
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    };
    freshFooter = footer;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [table reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
