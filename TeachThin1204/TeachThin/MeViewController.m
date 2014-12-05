//
//  MeViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14/11/12.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import "MeViewController.h"
#import "SetViewController.h"
#import "HealthFileViewController.h"
#import "PlanViewController.h"
#import "MyFamilyViewController.h"
#import "RaiseMeViewController.h"
#import "CollectionViewController.h"
#import "MessageViewController.h"


@interface MeViewController ()

@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
  
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView * bgimgV =[[UIImageView alloc]init];
    bgimgV.frame = CGRectMake(0, 0, WIDTH_VIEW(self.view), HEIGHT_VIEW(self.view));
    bgimgV.image = [UIImage imageNamed:@"mebg"];
    
    [self.view addSubview:bgimgV];
    
  
    [self setlayout];
}

-(void)setlayout
{
   

    UIImageView * imgv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 12, 21)];
    imgv.image = [UIImage imageNamed:@"backbtn"];
    
    UIImageView * imgv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
    imgv1.image = [UIImage imageNamed:@"setbtn"];
  
    
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, WIDTH_VIEW(self.view)/6, 44);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addSubview:imgv];
    
    
    setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(WIDTH_VIEW(self.view)*5/6, 20, WIDTH_VIEW(self.view)/6, 44);
    setBtn.backgroundColor = [UIColor clearColor];
    [setBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [setBtn addSubview:imgv1];
    [setBtn addTarget:self action:@selector(photoChange) forControlEvents:UIControlEventTouchUpInside];

    
    headimg = [[UIImageView alloc]init];
    headimg.frame = CGRectMake(WIDTH_VIEW(self.view)*3/8, 20, WIDTH_VIEW(self.view)/4, WIDTH_VIEW(self.view)/4);
    headimg.layer.cornerRadius = WIDTH_VIEW(self.view)/8;
    headimg.image = [UIImage imageNamed:@"headimg"];
    
    
    
    label  = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_VIEW(self.view)/4, VIEW_MAXY(headimg)+15, WIDTH_VIEW(self.view)/2, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"内马尔‘达席尔瓦";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16.0];

    
    header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 162)];
    
    [header addSubview:backBtn];
    [header addSubview:setBtn];
    [header addSubview:headimg];
    [header addSubview:label];
    

    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), HEIGHT_VIEW(self.view)) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 45;
    [table setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    table.scrollEnabled = YES;
    table.userInteractionEnabled = YES;
    table.tableHeaderView = header;
    table.tableFooterView = footer;
    table.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mebg"]];
    [self.view addSubview:table];
    
   
   
    
}
#pragma table datasorce;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section==2) {
        return 60;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 20;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section==0) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell * cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor clearColor];
        if (indexPath.section ==2) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section==2||indexPath.section==3) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cellimg =[[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 21, 21)];
        [cell.contentView addSubview:cellimg];
        
        celltitle = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_MAXX(cellimg)+20, 7, WIDTH_VIEW(cell)*5/8, 30)];
        celltitle.textAlignment = NSTextAlignmentLeft;
        celltitle.font = [UIFont systemFontOfSize:16.0];
        [cell.contentView addSubview:celltitle];
    
    }
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cellimg.image = [UIImage imageNamed:@"row1"];
                    celltitle.text = @"健康档案";
            
                }
                    break;
                    case 1:
                {
                    cellimg.image = [UIImage imageNamed:@"row2"];
                    celltitle.text = @"我的计划";
                }
                    break;
                    case 2:
                {
                    cellimg.image = [UIImage imageNamed:@"row3"];
                    celltitle.text = @"我的家人";
                }
                    break;
                default:
                    break;
            }
        }
            break;
             case 1:
        {
            if (indexPath.row ==0) {
                cellimg.image = [UIImage imageNamed:@"row4"];
                celltitle.text = @"养我";
            }
        }
            break;
            case 2:
        {
            cellimg.hidden = YES;
            celltitle.hidden = YES;
            
            UIImageView * img1 = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 44, 44)];
            img1.image = [UIImage imageNamed:@"collect"];
            
            UIImageView * img2 = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 44, 44)];
            img2.image = [UIImage imageNamed:@"message"];
            
            
            
            collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            collectBtn.frame = CGRectMake(60, 0, 60, 60);
            [collectBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [collectBtn addSubview:img1];
            [cell.contentView addSubview:collectBtn];
            
            messageBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
            messageBtn.frame = CGRectMake(200, 0, 60, 60);
            [messageBtn addTarget:self action:@selector(messageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [messageBtn addSubview:img2];
            [cell.contentView addSubview:messageBtn];
            
            
            
        }
            break;
            case 3:
        {
            if (indexPath.row ==0) {
                cellimg.image = [UIImage imageNamed:@"row5"];
                celltitle.text = @"退出登录";
            }
        }
            break;
        default:
            break;
    }
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    HealthFileViewController * hfvc = [[HealthFileViewController alloc]init];
                    [self.navigationController pushViewController:hfvc animated:YES];
                    
                }
                    break;
                case 1:
                {
                    PlanViewController * planvc = [[PlanViewController alloc]init];
                    [self.navigationController pushViewController:planvc animated:YES];
                }
                    break;
                case 2:
                {
                    MyFamilyViewController * mfvc = [[MyFamilyViewController alloc]init];
                    [self.navigationController pushViewController:mfvc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            if (indexPath.row ==0) {
                RaiseMeViewController * rmvc = [[RaiseMeViewController alloc]init];
                [self.navigationController pushViewController:rmvc animated:YES];
            }
        }
        default:
            break;
    }
}
-(void)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)photoChange
{
    SetViewController * setvc = [[SetViewController alloc]init];
    [self.navigationController pushViewController:setvc animated:YES];
}
-(void)collectBtnClick:(id)sender
{
    CollectionViewController * collectionVC = [[CollectionViewController alloc]init];
    [self.navigationController pushViewController:collectionVC animated:YES];
}
-(void)messageBtnClick:(id)sender
{
  
    MessageViewController * messageVC = [[MessageViewController alloc]init];
    [self.navigationController pushViewController:messageVC animated:YES];
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
