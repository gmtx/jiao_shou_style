//
//  MyPlanViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "MyPlanViewController.h"

@interface MyPlanViewController ()

@end

@implementation MyPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"每日食谱";
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
    NSLog(@"%@",_datetime);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arr = [[NSArray alloc]initWithObjects:@"早餐",@"早餐加餐",@"午餐",@"午餐加餐",@"晚餐", @"晚餐加餐", nil];
    
    [self setlayout];
    
}
-(void)setlayout
{
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view)/3, 35)];
    label.text = @"手动填写食谱";
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    
    header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 35)];
    [header addSubview:label];
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 30, WIDTH_VIEW(self.view)-40, 40);
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"上传" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 100)];
    [footer addSubview:sureBtn];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), HEIGHT_VIEW(self.view)) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.tableHeaderView = header;
    table.tableFooterView = footer;
    [self.view addSubview:table];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 56;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [_arr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell * cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selected = NO;
        
        _celltitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH_VIEW(cell.contentView)/4, 36)];
        _celltitle.textAlignment = NSTextAlignmentCenter;
        _celltitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        _celltitle.textColor = [UIColor blackColor];
        [cell.contentView addSubview:_celltitle];
        
        
    }
    
    //键盘上面的工具栏
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [topView setItems:buttonsArray];
    
    
    switch (indexPath.section) {
        case 0:
        {
            tf1 = [[UITextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(_celltitle)+10, 10, WIDTH_VIEW(self.view)*5/8, 36)];
            tf1.placeholder = @"请输入";
            tf1.clearButtonMode = UITextFieldViewModeWhileEditing;
            tf1.autocorrectionType = UITextAutocorrectionTypeNo;
            tf1.keyboardType = UIKeyboardAppearanceDefault;
            tf1.returnKeyType = UIReturnKeyDefault;
            tf1.delegate = self;
            tf1.autocapitalizationType = UITextAutocapitalizationTypeNone;
            tf1.inputAccessoryView = topView;
            [cell.contentView addSubview:tf1];
            
        }
            break;
            case 1:
        {
            tf2 = [[UITextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(_celltitle)+10, 10, WIDTH_VIEW(self.view)*5/8, 36)];
            tf2.placeholder = @"请输入";
            tf2.clearButtonMode = UITextFieldViewModeWhileEditing;
            tf2.autocorrectionType = UITextAutocorrectionTypeNo;
            tf2.keyboardType = UIKeyboardAppearanceDefault;
            tf2.returnKeyType = UIReturnKeyDefault;
            tf2.delegate = self;
            tf2.autocapitalizationType = UITextAutocapitalizationTypeNone;
            tf2.inputAccessoryView = topView;
            [cell.contentView addSubview:tf2];
        }
            break;
            case 2:
        {
            tf3 = [[UITextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(_celltitle)+10, 10, WIDTH_VIEW(self.view)*5/8, 36)];
            tf3.placeholder = @"请输入";
            tf3.clearButtonMode = UITextFieldViewModeWhileEditing;
            tf3.autocorrectionType = UITextAutocorrectionTypeNo;
            tf3.keyboardType = UIKeyboardAppearanceDefault;
            tf3.returnKeyType = UIReturnKeyDefault;
            tf3.delegate = self;
            tf3.autocapitalizationType = UITextAutocapitalizationTypeNone;
            tf3.inputAccessoryView = topView;
            [cell.contentView addSubview:tf3];
        }
            break;
            case 3:
        {
            tf4 = [[UITextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(_celltitle)+10, 10, WIDTH_VIEW(self.view)*5/8, 36)];
            tf4.placeholder = @"请输入";
            tf4.clearButtonMode = UITextFieldViewModeWhileEditing;
            tf4.autocorrectionType = UITextAutocorrectionTypeNo;
            tf4.keyboardType = UIKeyboardAppearanceDefault;
            tf4.returnKeyType = UIReturnKeyDefault;
            tf4.delegate = self;
            tf4.autocapitalizationType = UITextAutocapitalizationTypeNone;
            tf4.inputAccessoryView = topView;
            [cell.contentView addSubview:tf4];
        }
            break;
            case 4:
        {
            tf5 = [[UITextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(_celltitle)+10, 10, WIDTH_VIEW(self.view)*5/8, 36)];
            tf5.placeholder = @"请输入";
            tf5.clearButtonMode = UITextFieldViewModeWhileEditing;
            tf5.autocorrectionType = UITextAutocorrectionTypeNo;
            tf5.keyboardType = UIKeyboardAppearanceDefault;
            tf5.returnKeyType = UIReturnKeyDefault;
            tf5.delegate = self;
            tf5.autocapitalizationType = UITextAutocapitalizationTypeNone;
            tf5.inputAccessoryView = topView;
            [cell.contentView addSubview:tf5];
            
            
        }
            break;
            case 5:
        {
            tf6 = [[UITextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(_celltitle)+10, 10, WIDTH_VIEW(self.view)*5/8, 36)];
            tf6.placeholder = @"请输入";
            tf6.clearButtonMode = UITextFieldViewModeWhileEditing;
            tf6.autocorrectionType = UITextAutocorrectionTypeNo;
            tf6.keyboardType = UIKeyboardAppearanceDefault;
            tf6.returnKeyType = UIReturnKeyDefault;
            tf6.delegate = self;
            tf6.autocapitalizationType = UITextAutocapitalizationTypeNone;
            tf6.inputAccessoryView = topView;
            [cell.contentView addSubview:tf6];
        }
            break;
        default:
            break;
    }
    

    
    _celltitle.text = [_arr objectAtIndex:indexPath.section];
    return cell;
}
//去掉输入的前后空格
-(NSString *)removespace:(UITextField *)textfield {
    return [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
-(void) dismissKeyBoard
{
    
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    [tf3 resignFirstResponder];
    [tf4 resignFirstResponder];
    [tf5 resignFirstResponder];
    [tf6 resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0,0,VIEW_WEIGHT, VIEW_HEIGHT);
    [UIView commitAnimations];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    [tf3 resignFirstResponder];
    [tf4 resignFirstResponder];
    [tf5 resignFirstResponder];
    [tf6 resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0,0,VIEW_WEIGHT, VIEW_HEIGHT);
    [UIView commitAnimations];


}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    [tf3 resignFirstResponder];
    [tf4 resignFirstResponder];
    [tf5 resignFirstResponder];
    [tf6 resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0,0,VIEW_WEIGHT, VIEW_HEIGHT);
    [UIView commitAnimations];
    
    return YES;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==tf3||textField==tf4) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        
        self.view.frame=CGRectMake(self.view.frame.origin.x, -120, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }else if (textField==tf5||textField==tf6)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        
        self.view.frame=CGRectMake(self.view.frame.origin.x, -250, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];    }
    
    
    
    return YES;
}

-(BOOL)havedata
{
    if (tf1.text==nil&&tf2.text==nil&&tf3.text==nil&&tf4.text==nil&&tf5.text==nil&&tf6.text==nil) {
        return NO;
    }
    return YES;
}

-(void)sureBtnClick:(id)sender
{
    NSLog(@"上传");
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    [tf3 resignFirstResponder];
    [tf4 resignFirstResponder];
    [tf5 resignFirstResponder];
    [tf6 resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0,0,VIEW_WEIGHT, VIEW_HEIGHT);
    [UIView commitAnimations];
    
    NSString * breakfast=[NSString stringWithFormat:@"%@",tf1.text];
    NSString * breakfastadd = [NSString stringWithFormat:@"%@",tf2.text];
    NSString * lunch = [NSString stringWithFormat:@"%@",tf3.text];
     NSString * lunchadd = [NSString stringWithFormat:@"%@",tf4.text];
     NSString * dinner = [NSString stringWithFormat:@"%@",tf5.text];
     NSString * dinneradd = [NSString stringWithFormat:@"%@",tf6.text];

     NSString * uid = @"1";
     NSString * date = @"2014-12-1";
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",date,@"date",breakfast,@"breakfast",breakfastadd,@"breakfastadd",lunch,@"lunch",lunchadd,@"lunchadd",dinner,@"dinner",dinneradd,@"dinneradd", nil];
    NSLog(@"%@",postDict);
    NSString * url = URL_Recipes_noplan;
    NSLog(@"*****%@",url);
    JSHttpRequest * request = [[JSHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:url pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        //如果获取到数据网络页面消失
        [self removeNonetView];
        //加载框消失
        [MBHUDView dismissCurrentHUD];
        NSLog(@"^^^^^%@",obj);
        NSInteger result =[[obj valueForKey:@"code"]integerValue] ;
        if (result==201) {
            UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的数据已经提交成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
        }
     
        
    };
    request.failureGetData = ^(void){
        [MBHUDView dismissCurrentHUD];
        [self showNoNetView];//显示没有网络页面
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
