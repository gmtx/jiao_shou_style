//
//  SexViewController.m
//  FootballReservation
//
//  Created by 巩鑫 on 14-10-21.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import "SexViewController.h"
#import "ManageVC.h"
@interface SexViewController ()

@end

@implementation SexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"性别";
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
 
    right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
    self.navigationItem.rightBarButtonItem = right;

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setlayout];
    
}
-(void)setlayout
{
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 148) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.scrollEnabled = NO;
    table.bounces = NO;
   
    table.rowHeight = 44;
    [table setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    [self.view addSubview:table];
}
#pragma table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell;
    UIButton * btn;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(280, 13, 18, 18);
        btn.tag = 3000+indexPath.row;
        btn.hidden = YES;
        btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"langou"]];
        //[btn setImage:[UIImage imageNamed:@"select_red"] forState:UIControlStateNormal];
        [cell addSubview:btn];

    }

    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"男";
            cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16.0];
            cell.textLabel.textColor=[UIColor blackColor];
           
            if([[[ManageVC sharedManage] userSex] isEqualToString:@"男"]){
                btn.hidden = NO;
            }
        }
            break;
            case 1:
        {
            cell.textLabel.text = @"女";
            cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16.0];
           cell.textLabel.textColor=[UIColor blackColor];
            if([[[ManageVC sharedManage] userSex] isEqualToString:@"女"]){
                btn.hidden = NO;
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
    
    UIButton * btnBoy=(UIButton*)[self.view viewWithTag:3000];
    UIButton * btnGril=(UIButton*)[self.view viewWithTag:3001];
    
    switch (indexPath.row) {
        case 0:
        {
            btnBoy.hidden=NO;
            btnGril.hidden=YES;
            self.sex=@"男";
              NSLog(@"男");
        }
            break;
        case 1:
        {
            btnBoy.hidden = YES;
            btnGril.hidden = NO;
            self.sex=@"女";
               NSLog(@"女");
           
            
        }
            break;
        default:
            break;
    }
    
    
}




-(void)rightClick:(id)sender
{
    NSLog(@"%@",self.sex);
    if (_pushFlag==1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sexchange" object:self.sex];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (_pushFlag==2)
    {
    [self.navigationController popViewControllerAnimated:YES];
    }
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
