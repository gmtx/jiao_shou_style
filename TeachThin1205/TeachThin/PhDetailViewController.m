//
//  PhDetailViewController.m
//  TeachThin
//
//  Created by 王园园 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "PhDetailViewController.h"
#import "CompareViewController.h"

@interface PhDetailViewController ()

@end

@implementation PhDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"拍一拍";
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
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80, VIEW_WEIGHT, 220)];
    imgView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:imgView];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, VIEW_MAXY(imgView)+20, VIEW_WEIGHT, 50)];
    lable.backgroundColor = [UIColor whiteColor];
    lable.text = @"    描述";
    lable.textColor = [UIColor blackColor];
    lable.layer.borderColor  =[[UIColor lightGrayColor] colorWithAlphaComponent:0.6].CGColor;
    lable.layer.borderWidth = 0.6;
    [self.view addSubview:lable];
    
    lable.userInteractionEnabled = YES;
    nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(80, 0,VIEW_WEIGHT-60,50)];
    nameTextField.textColor = [UIColor grayColor];
    nameTextField.borderStyle = UITextBorderStyleNone;
    nameTextField.placeholder = @"请输入名称";
    nameTextField.delegate = self;
    [lable addSubview:nameTextField];
    
    UIButton *OKbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    OKbtn.frame = CGRectMake(20., VIEW_MAXY(lable)+60, VIEW_WEIGHT-40, 40);
    [OKbtn setTitle:@"确定" forState:UIControlStateNormal];
    OKbtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.];
    [OKbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [OKbtn setBackgroundColor:RGBACOLOR(249., 50., 60., 1)];
    OKbtn.layer.cornerRadius = 5.;
    [OKbtn addTarget:self action:@selector(OKBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:OKbtn];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"takeImg=%@",_TakeImg);
    imgView.image = _TakeImg;
}
-(void)OKBtnPress
{
    if(nameTextField.text.length<=0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先输入菜名" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        CompareViewController *compareVC = [[CompareViewController alloc]init];
        compareVC.Foodname = nameTextField.text;
        compareVC.selfImg = _TakeImg;
        compareVC.Foodtype = _foodType;
        [self.navigationController pushViewController:compareVC animated:YES];
    }
}
#pragma mark - 
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(0, -60, VIEW_WEIGHT, VIEW_HEIGHT);
    }];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT);
    }];
    [nameTextField resignFirstResponder];
    return YES;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT);
    }];
    [nameTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
