//
//  CheckoutViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "CheckoutViewController.h"
#import "OrderViewController.h"
@interface CheckoutViewController ()

@end

@implementation CheckoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"食物结算";
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [_postArr removeAllObjects];
    _postArr = [[NSMutableArray alloc]init];
    [table reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _Arr =  [[NSArray alloc]initWithObjects:@"宫保鸡丁",@"鱼香肉丝",@"糖醋里脊",@"鸡蛋西红柿",@"干煸豆角", nil];
    
    [self setlayout];
}
-(void)setlayout
{

    Allprice = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH_VIEW(self.view)-20, 30)];
    Allprice.text = @"总账单:$100元";
    Allprice.textColor = [UIColor blackColor];
    Allprice.textAlignment = NSTextAlignmentRight;
    Allprice.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    
    
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 50, WIDTH_VIEW(self.view)-40, 40);
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 130)];
    footer.backgroundColor = GXRandomColor;
    [footer addSubview:Allprice];
    [footer addSubview:sureBtn];
    

    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), HEIGHT_VIEW(self.view)) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = footer;
    [table setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    [self.view addSubview:table];
    
    
}
#pragma table delegate;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
   
    return [_Arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UIImageView * imgv;
    UILabel * name;
    UILabel * price;
    
    UITableViewCell * cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.accessoryType = UITableViewCellAccessoryNone;
        imgv = [[UIImageView alloc]initWithFrame:CGRectMake(40, 7.5, 40, 40)];
        imgv.backgroundColor  = GXRandomColor;
        [cell.contentView addSubview:imgv];
        
        name = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_MAXX(imgv)+10, 15, 140, 26)];
        name.backgroundColor = GXRandomColor;
        name.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        name.textAlignment = NSTextAlignmentLeft;
        name.textColor = [UIColor blackColor];
        [cell.contentView addSubview:name];
        
        price = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_MAXX(name), 15, 60, 26)];
        price .backgroundColor = GXRandomColor;
        price .font =  [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        price .textAlignment = NSTextAlignmentRight;
        price .textColor = [UIColor blackColor];
        price.text = @"$20";
        [cell.contentView addSubview:price ];
        
        
    }
 
 
    name.text = [_Arr objectAtIndex:indexPath.row];
    price.text = @"$20";
    
    selectBtn = [GXSelectBtn buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(0, 7.5, 40, 40);
    selectBtn.backgroundColor = GXRandomColor;
    [selectBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    [selectBtn setImageEdgeInsets:UIEdgeInsetsMake(8.0,8.0, 8.0, 8.0)];
    [selectBtn addTarget:self action:@selector(selectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.tag = 1000+indexPath.section;
    selectBtn.info = [_Arr objectAtIndex:indexPath.row];
        selectBtn.selected = NO;
    
    [_postArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(obj==selectBtn.info ){
            selectBtn.selected = YES;
            NSLog(@"**************%d",indexPath.section);
        }
    }];
    [cell.contentView addSubview:selectBtn];
    
    
    return cell;
}
-(void)selectBtnPress:(id)sender
{
    //获取点击的按钮
    GXSelectBtn *btn = (GXSelectBtn *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [_postArr addObject:btn.info];
    }else
    {
        [_postArr removeObject:btn.info];
    }
    
    NSLog(@"%@",_postArr);
    
    
    
    
}
-(void)sureBtnClick:(id)sender
{
    NSLog(@"************%@",_postArr);
    OrderViewController * orderVC = [[OrderViewController alloc]init];
    [self.navigationController pushViewController:orderVC animated:YES];
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
