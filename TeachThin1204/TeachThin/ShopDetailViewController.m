//
//  ShopDetailViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-14.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "CheckoutViewController.h"
@interface ShopDetailViewController ()

@end

@implementation ShopDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title  = @"商品详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setlayout];
    
}
-(void)setlayout
{
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 20, WIDTH_VIEW(self.view)-40, 40);
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 100)];
    [footer addSubview:sureBtn];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), HEIGHT_VIEW(self.view)) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = footer;
    [table setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    [self.view addSubview:table];
    
}

#pragma table delegate;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        return 80;
    }if (indexPath.row ==2) {
        UITableViewCell *cell =(UITableViewCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
        UILabel *lable = (UILabel *)[cell viewWithTag:1000];
        return CGRectGetHeight(lable.frame)+20;
    }
  
    return 60;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UIImageView * imgv;
    UILabel * Foodname;
    UILabel * Restaurantname;
    UILabel * price;
    UILabel * tel;
    UILabel * address;
    UILabel * content;
    
    
    
    UITableViewCell * cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.accessoryType = UITableViewCellAccessoryNone;
  
    }
    switch (indexPath.row) {
        case 0:
        {
            imgv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
            imgv.backgroundColor = GXRandomColor;
            [cell.contentView addSubview:imgv];
            
            Foodname = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_MAXX(imgv)+20, 10, 200, 20)];
            Foodname.backgroundColor = GXRandomColor;
            Foodname.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
            Foodname.textAlignment = NSTextAlignmentLeft;
            Foodname.textColor = [UIColor blackColor];
            Foodname.text = @"宫保鸡丁";
            [cell.contentView addSubview:Foodname];
            
            Restaurantname = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_MAXX(imgv)+20, 30, 200, 20)];
            Restaurantname.backgroundColor = GXRandomColor;
            Restaurantname.font =  [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
            Restaurantname.textAlignment = NSTextAlignmentLeft;
            Restaurantname.textColor = [UIColor grayColor];
            Restaurantname.text = @"老家肉饼店";
            [cell.contentView addSubview:Restaurantname];
            
            price = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_MAXX(imgv)+20, 50, 200, 20)];
            price.backgroundColor = GXRandomColor;
            price.font =  [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
            price.textAlignment = NSTextAlignmentLeft;
            price.textColor = [UIColor grayColor];
            price.text = @"优惠价:8元";
            [cell.contentView addSubview:price];
            
        }
            break;
          case 1:
        {
            tel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH_VIEW(self.view)-20, 20)];
            tel.backgroundColor = GXRandomColor;
            tel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
            tel.textAlignment = NSTextAlignmentLeft;
            tel.textColor = [UIColor blackColor];
            tel.text = @"电话:010-88888888";
            [cell.contentView addSubview:tel];
            
            address = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, WIDTH_VIEW(self.view)-20, 20)];
            address.backgroundColor = GXRandomColor;
            address.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
            address.textAlignment = NSTextAlignmentLeft;
            address.textColor = [UIColor blackColor];
            address.text = @"地址:三元桥东方凤凰楼下";
            [cell.contentView addSubview:address];

        }
            break;
            case 2:
        {
            content = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH_VIEW(self.view)-20, 40)];
            content.backgroundColor = GXRandomColor;
            content.font =  [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
            content.textAlignment = NSTextAlignmentLeft;
            content.textColor = [UIColor blackColor];
            content.text = @"餐厅简介：俏江南是国际餐饮服务管理公司品牌。创始于2000年，自成立以来，俏江南遵循着创新、发展、品位与健康的企业核心精神，不断追求品牌的创新和突破，从国贸第一家餐厅到北京、上海、天津、武汉、成都、深圳、苏州、青岛、沈阳、南京、合肥等50多家店，从服务商业精英、政界要员到2008北京奥运会场、2010上海世博会……历经十年的健康成长，俏江南已经成为了中国最具发展潜力的国际餐饮服务管理公司之一。2011年6月13日，汪小菲正式接替母亲张兰出任俏江南CEO。";
            content.numberOfLines = 0;
            content.lineBreakMode = NSLineBreakByCharWrapping;
            content.tag = 1000;
            [content sizeToFit];
            [cell.contentView addSubview:content];
            
            
        }
            break;
        default:
            break;
    }
    
    
    
    
    return cell;
}
-(void)sureBtnClick:(id)sender
{
    CheckoutViewController * COVC = [[CheckoutViewController alloc]init];
    [self.navigationController pushViewController:COVC animated:YES];
    
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
