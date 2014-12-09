//
//  LoginViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-13.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "LoginViewController.h"
#import "HomePageViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "ManageVC.h"
#import "EaseMobProcessor.h"
#import "ApplyFriendControllerViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

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
    bgimgV.image = [UIImage imageNamed:@"loginbg"];
    
    [self.view addSubview:bgimgV];
    
    [self setlayout];
}
-(void)setlayout
{
    //键盘上面的工具栏
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [topView setItems:buttonsArray];
    
    // 用户头像
    imgv = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_VIEW(self.view)*11/32, VIEW_HEIGHT/8, WIDTH_VIEW(self.view)*9/32, WIDTH_VIEW(self.view)*9/32)];
    imgv.backgroundColor = GXRandomColor;
    imgv.layer.cornerRadius = WIDTH_VIEW(self.view)*9/64;
    imgv.layer.borderColor = [UIColor whiteColor].CGColor;
    imgv.layer.borderWidth = 1.0f;
    imgv.layer.masksToBounds = YES;
    [self.view addSubview:imgv];
    
    UIView * v1 = [[UIView alloc]init];
    v1.frame = CGRectMake(WIDTH_VIEW(self.view)*3/32, VIEW_MAXY(imgv)+30,WIDTH_VIEW(self.view)*13/16 , 40);
    v1.layer.borderWidth = 1;
    v1.layer.borderColor = [UIColor whiteColor].CGColor;
    v1.backgroundColor = [UIColor clearColor];
    
    
    UIView * v3 = [[UIView alloc]init];
    v3.frame = CGRectMake(1, 1, WIDTH_VIEW(v1)*38/260, HEIGHT_VIEW(v1)-2);
    v3.backgroundColor = [UIColor whiteColor];
    [v1 addSubview:v3];
    [self.view addSubview:v1];
    
    
    UIView * v2 = [[UIView alloc]init];
    v2.frame = CGRectMake(WIDTH_VIEW(self.view)*3/32, VIEW_MAXY(v1)+15,WIDTH_VIEW(self.view)*13/16 , 40);
    v2.layer.borderWidth = 1;
    v2.layer.borderColor = [UIColor whiteColor].CGColor;
    v2.backgroundColor = [UIColor clearColor];
    UIView * v4 = [[UIView alloc]init];
    v4.frame = CGRectMake(1, 1, WIDTH_VIEW(v2)*38/260, HEIGHT_VIEW(v2)-2);
    v4.backgroundColor = [UIColor whiteColor];
    [v2 addSubview:v4];
    
    
    [self.view addSubview:v2];
    
 
    imgv1 = [[UIImageView alloc]init];
    imgv1.frame = CGRectMake(13, 10, 14, 19);
    imgv1.image = [UIImage imageNamed:@"phone"];
    [v1 addSubview:imgv1];
    
    imgv2 = [[UIImageView alloc]init];
    imgv2.frame = CGRectMake(13, 11, 14, 16);
    imgv2.image = [UIImage imageNamed:@"lock"];
    [v2 addSubview:imgv2];
    
    tf1 = [[GXTextField alloc]initWithFrame:CGRectMake(WIDTH_VIEW(self.view)*9/32, VIEW_MAXY(imgv)+30, WIDTH_VIEW(self.view)/2, 40)];
    tf1.placeholder = @"请输入账号";
    tf1.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf1.autocorrectionType = UITextAutocorrectionTypeNo;
    tf1.keyboardType = UIKeyboardAppearanceDefault;
    tf1.returnKeyType = UIReturnKeyDefault;
    tf1.delegate = self;
    tf1.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf1.textColor = [UIColor whiteColor];
    tf1.inputAccessoryView = topView;
    [self.view addSubview:tf1];
    
    tf2 = [[GXTextField alloc]initWithFrame:CGRectMake(WIDTH_VIEW(self.view)*9/32, VIEW_MAXY(v1)+15, WIDTH_VIEW(self.view)/2,40)];
    tf2.placeholder = @"请输入密码";
    tf2.secureTextEntry = YES;
    tf2.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf2.autocorrectionType = UITextAutocorrectionTypeNo;
    tf2.keyboardType = UIKeyboardAppearanceDefault;
    tf2.returnKeyType = UIReturnKeyDefault;
    tf2.delegate = self;
    tf2.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf2.textColor = [UIColor whiteColor];
    tf2.inputAccessoryView = topView;
    [self.view addSubview:tf2];
    
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(WIDTH_VIEW(self.view)*3/32, VIEW_MAXY(tf2)+20, WIDTH_VIEW(self.view)*26/32, 40);
    loginBtn.layer.cornerRadius = 3;
    [loginBtn setBackgroundColor:RGBACOLOR(42, 112, 222, 1)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    [loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: loginBtn];
                                                         
    ForgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ForgetBtn.frame = CGRectMake(WIDTH_VIEW(self.view)*1/32, HEIGHT_VIEW(self.view)-50, WIDTH_VIEW(self.view)*14/32, 40);
    ForgetBtn.layer.cornerRadius = 3;
    [ForgetBtn setBackgroundColor:[UIColor clearColor]];
    [ForgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    ForgetBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    [ForgetBtn addTarget:self action:@selector(forgetClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: ForgetBtn];
    
    RegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    RegisterBtn.frame = CGRectMake(WIDTH_VIEW(self.view)*17/32, HEIGHT_VIEW(self.view)-50, WIDTH_VIEW(self.view)*12/32, 40);
    RegisterBtn.backgroundColor = [UIColor clearColor];
    RegisterBtn.layer.cornerRadius = 3;
    [RegisterBtn setTitle:@"新用户" forState:UIControlStateNormal];
    RegisterBtn.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    [RegisterBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    RegisterBtn.layer.borderWidth = 1;
    RegisterBtn.layer.borderColor =  RGBACOLOR(255.0, 255.0, 255.0, 1).CGColor;
    [self.view addSubview:RegisterBtn];
                                                         

}
-(void)loginClick:(id)sender{
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    [MBHUDView hudWithBody:@"加载中" type:MBAlertViewHUDTypeActivityIndicator hidesAfter:100000.0 show:YES];
 
    NSString * username = [NSString stringWithFormat:@"%@",tf1.text];
    NSString * password = [NSString stringWithFormat:@"%@",tf2.text];
    if ([username isEqualToString:@""]||[password isEqualToString:@""]) {
        [MBHUDView dismissCurrentHUD];
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的用户名或密码" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];

        
    }else {
        NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:username,@"uid",password,@"pwd",nil];
        
        NSString * url = URL_Login;
        NSLog(@"*****%@",url);
        JSHttpRequest * request = [[JSHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:url pragma:postDict ImageData:nil];
        request.successGetData = ^(id obj){
            //如果获取到数据网络页面消失
            [self removeNonetView];
            //加载框消失
            [MBHUDView dismissCurrentHUD];
            NSLog(@"^^^^^>>>>>>>>>>>>>%@",obj);
            NSString * result = [obj valueForKey:@"code"];
            NSString * uid = [obj valueForKey:@"uid"];
            NSString * reason = [obj valueForKey:@"errmsg"];
            if ([result isEqualToString:@"01"]) {
                NSLog(@"登录成功");
                    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
                        [[ApplyFriendControllerViewController shareController] clear];
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
                    } onQueue:nil];

                [ManageVC sharedManage].uid = [NSString stringWithFormat:@"%@",uid];
                [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
                [ManageVC sharedManage].LoginState = YES;
                 [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"islogin"];
                
                [[EaseMob sharedInstance].chatManager setNickname:username];
                [EaseMobProcessor login:NO WithUserName:username pwd:password];
                
                HomePageViewController * hpvc = [[HomePageViewController alloc]init];
                [self.navigationController pushViewController:hpvc animated:YES];
            }else if([result isEqualToString:@"00"])
            {
                NSLog(@"登录失败");
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        };
        request.failureGetData = ^(void){
            [MBHUDView dismissCurrentHUD];
            [self showNoNetView];//显示没有网络页面
        };
    }
}
-(void)forgetClick:(id)sender
{
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    ForgetPasswordViewController * fpvc = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:fpvc animated:YES];
}
-(void)registerClick:(id)sender
{
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    RegisterViewController * registervc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registervc animated:YES];
}
//去掉输入的前后空格
-(NSString *)removespace:(UITextField *)textfield {
    return [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
-(void) dismissKeyBoard
{
    
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0,0,VIEW_WEIGHT, VIEW_HEIGHT);
    [UIView commitAnimations];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0,0,VIEW_WEIGHT, VIEW_HEIGHT);
    [UIView commitAnimations];}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0,0,VIEW_WEIGHT, VIEW_HEIGHT);
    [UIView commitAnimations];
    
    return YES;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==tf2)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        
        self.view.frame=CGRectMake(self.view.frame.origin.x, -100, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    return YES;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
