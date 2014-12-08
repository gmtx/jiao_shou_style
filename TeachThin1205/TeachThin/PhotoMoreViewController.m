//
//  PhotoMoreViewController.m
//  TeachThin
//
//  Created by 王园园 on 14-11-26.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "PhotoMoreViewController.h"

@interface PhotoMoreViewController ()

@end

@implementation PhotoMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"食物详情";
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

    _titleArr = @[@"能量（kacl）",@"蛋白质(g)",@"脂肪(g)",@"碳水化合物(g)",@"水分",@"VA",@"VB1",@"VB2",@"VC",@"VE",@"钙",@"钠",@"铁",@"叶酸",@"胆固醇",@"膳食纤维"];
    _keyArr = @[@"energy",@"protein",@"fat",@"carbodydrates",@"water",@"VA",@"VB1",@"VB2",@"VC",@"VE",@"clacium",@"sodium",@"iron",@"folicacid",@"cholesterol",@"fiber"];
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
   
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT-70, VIEW_HEIGHT-60, 50, 50);
    [homeBtn setImage:[UIImage imageNamed:@"homeBtn"] forState:UIControlStateNormal];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
}
-(void)HomeBtnPress{
    
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

#pragma mark - UItableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
     static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UILabel *titleLable;
    UILabel *cotentLable;
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 140, 40)];
        titleLable.textAlignment = NSTextAlignmentLeft;
        titleLable.font = [UIFont systemFontOfSize:15.];
        titleLable.textColor = [UIColor blackColor];
        [cell addSubview:titleLable];
        
        cotentLable = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, 120, 40)];
        cotentLable.textAlignment = NSTextAlignmentLeft;
        cotentLable.font = [UIFont systemFontOfSize:15.];
        cotentLable.textColor = [UIColor blackColor];
        [cell addSubview:cotentLable];
    }
    titleLable.text = _titleArr[indexPath.row];
    NSString *detailStr = [_Datadict valueForKey:_keyArr[indexPath.row]];
    if(detailStr.length==0){
        cotentLable.text = @"0";
    }else{
        cotentLable.text = detailStr;
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.;
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
