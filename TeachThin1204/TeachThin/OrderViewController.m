//
//  OrderViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"订单详情";
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
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(40, 114, WIDTH_VIEW(self.view)-80, 60)];
    label1.text = @"您已经成功提交订单，我们的客服会在午餐前给您打电话，谢谢您的使用";
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    label1.numberOfLines = 3;
    [self.view addSubview:label1];
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(40, VIEW_MAXY(label1), WIDTH_VIEW(self.view)-80, 40)];
    label2.text = @"客服电话: 010-88888888";
    label2.textColor = [UIColor blackColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    [self.view addSubview:label2];
    
    
    
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
