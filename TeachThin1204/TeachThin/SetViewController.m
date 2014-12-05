//
//  SetViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14/11/13.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import "SetViewController.h"
#import "SexViewController.h"
#import "EatingViewController.h"
#import "EatingHabitsViewController.h"
#import "CaseViewController.h"
#import "ActStrengthViewController.h"
#import "SpecialCrowdViewController.h"



@interface SetViewController ()

@end

@implementation SetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"修改资料";
        
        UIBarButtonItem * right  = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
        self.navigationItem.rightBarButtonItem = right;
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(actStrength:) name:@"actStrength" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sexchange:) name:@"sexchange" object:nil];    
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(eating:) name:@"eating" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(case1:) name:@"case" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allergy:) name:@"allergy" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(special:) name:@"special" object:nil];
    
    
}
//-(void)actStrength:(NSNotification*)notification
//{
//    
//    id obj = [notification object];
//    NSLog(@"劳动强度的数据数组是%@",obj);
//    NSMutableArray * arr = [NSMutableArray arrayWithObjects:obj, nil];
//    NSMutableArray * arr1 = [arr objectAtIndex:0];
//    _actstrength = [arr1 componentsJoinedByString:@","];
//    NSLog(@"&&&&&&&&&&&&&&%@",_actstrength);
//    [table reloadData];
//    
//}
-(void)sexchange:(NSNotification*)notification
{
    id obj = [notification object];
    _userSex = [NSString stringWithFormat:@"%@",obj];
    NSLog(@"**************%@",_userSex);
    [table reloadData];
    
}


-(void)eating:(NSNotification*)notification
{
    id obj = [notification object];
    NSLog(@"饮食偏好的数据数组是%@",obj);
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:obj, nil];
    NSMutableArray * arr1 = [arr objectAtIndex:0];
    _eating= [arr1 componentsJoinedByString:@","];
    NSLog(@"&&&&&&&&&&&&&&%@",_eating);
    [table reloadData];
    
    
    
}

-(void)case1:(NSNotification*)notification
{
    id obj = [notification object];
    NSLog(@"病史的数据数组是%@",obj);
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:obj, nil];
    NSMutableArray * arr1 = [arr objectAtIndex:0];
    _case1= [arr1 componentsJoinedByString:@","];
    NSLog(@"&&&&&&&&&&&&&&%@",_case1);
    [table reloadData];
    
    
    
    
}
-(void)allergy:(NSNotification*)notification
{
    
    id obj = [notification object];
    NSLog(@"过敏源的数据数组是%@",obj);
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:obj, nil];
    NSMutableArray * arr1 = [arr objectAtIndex:0];
    _allergy= [arr1 componentsJoinedByString:@","];
    NSLog(@"&&&&&&&&&&&&&&%@",_allergy);
    [table reloadData];
    
}

-(void)special:(NSNotification*)notification
{
    
    id obj = [notification object];
    NSLog(@"特殊人群的数据数组是%@",obj);
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:obj, nil];
    NSMutableArray * arr1 = [arr objectAtIndex:0];
    _special= [arr1 componentsJoinedByString:@","];
    NSLog(@"&&&&&&&&&&&&&&%@",_special);
    [table reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GXRandomColor;
    _Arr = [[NSArray alloc]initWithObjects:@"汉族",@"壮族",@"满族",@"回族",@"苗族",@"维吾尔族",@"土家族",@"彝族",@"蒙古族",@"藏族",@"布依族",@"朝鲜族",@"瑶族", nil];
    _Arr1 = [[NSArray alloc]initWithObjects:@"小学",@"初中",@"高中",@"大专",@"本科",@"研究生",@"硕士",@"博士", nil];
    
    
    [self setlayout];

}

-(void)setlayout
{
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), HEIGHT_VIEW(self.view)) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}
#pragma table delegate;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 10;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 11;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section==3) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell * cell;

    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _celltitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, 80, 36)];
        _celltitle.textAlignment = NSTextAlignmentCenter;
        _celltitle.font = [UIFont systemFontOfSize:15.0];
        _celltitle.textColor = [UIColor blackColor];
        [cell.contentView addSubview:_celltitle];
        
        _cellcontent = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 140, 24)];
        [cell.contentView addSubview: _cellcontent];
        
        
    }
    UIToolbar * topview = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topview setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [topview setItems:buttonsArray];
    
    
    switch (indexPath.section) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            _celltitle.text = @"头像";
            
            _imgv = [[UIImageView alloc]initWithFrame:CGRectMake(250, 2, 40, 40)];
            _imgv.layer.cornerRadius = 20;
            _imgv.backgroundColor = GXRandomColor;
            _imgv.layer.masksToBounds = YES;
            [cell.contentView addSubview:_imgv];
            
            [_cellcontent removeFromSuperview];
            
        }
            break;
            case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            _celltitle.text = @"手机号";
            
            tf1 = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 140, 24)];
            tf1.placeholder = @"请输入手机号";
            tf1.clearButtonMode = UITextFieldViewModeWhileEditing;
            tf1.autocorrectionType = UITextAutocorrectionTypeNo;
            tf1.keyboardType = UIKeyboardTypeNumberPad;
            tf1.returnKeyType = UIReturnKeyDefault;
            tf1.delegate = self;
            tf1.autocapitalizationType = UITextAutocapitalizationTypeNone;
            tf1.inputAccessoryView = topview;
            [cell.contentView addSubview:tf1];
            
            
            
            
        }
            break;
            case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            _celltitle.text = @"昵称";
            
            tf2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 140, 24)];
            tf2.placeholder = @"请输入昵称";
            tf2.clearButtonMode = UITextFieldViewModeWhileEditing;
            tf2.autocorrectionType = UITextAutocorrectionTypeNo;
            tf2.keyboardType = UIKeyboardAppearanceDefault;
            tf2.returnKeyType = UIReturnKeyDefault;
            tf2.delegate = self;
            tf2.autocapitalizationType = UITextAutocapitalizationTypeNone;
            tf2.inputAccessoryView = topview;
             [cell.contentView addSubview:tf2];
            
            
            
        }
            break;
            case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    _celltitle.text = @"年龄";
                }
                    break;
                    case 1:
                {
                    _celltitle.text = @"性别";
                    _cellcontent.text = _userSex;
                }
                    break;
                default:
                    break;
            }
        }
            break;
            case 4:
        {
            _celltitle.text = @"民族";
        }
            break;
        case 5:
        {
            _celltitle.text = @"文化程度";
        }
            break;
        case 6:
        {
            _celltitle.text = @"饮食嗜好";
            _cellcontent.text = _eating;
    
        }
            break;
        case 7:
        {
             _celltitle.text = @"慢性病";
            _cellcontent.text = _case1;
        }
            break;
        case 8:
        {
              _celltitle.text = @"过敏源";
            _cellcontent.text = _allergy;
        
        }
            break;
        case 9:
        {
             _celltitle.text = @"特殊人群";
            _cellcontent.text = _special;
        }
            break;
        case 10:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
             _celltitle.text = @"目标体重";
        }
            break;
        default:
            break;
    }
    _cellcontent.textAlignment = NSTextAlignmentCenter;
    _cellcontent.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    _cellcontent.backgroundColor = GXRandomColor;
    _cellcontent.textColor = [UIColor blackColor];
    _cellcontent.lineBreakMode = NSLineBreakByCharWrapping;
    _cellcontent.numberOfLines = 0 ;
    _cellcontent.tag = 1000;
    [_cellcontent sizeToFit];
    
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    switch (indexPath.section) {
        case 0:
        {
            as =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
            as.actionSheetStyle = UIActionSheetStyleBlackOpaque ;
            as.tag = 100;
            [as showInView:self.view];
            
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
               case 0:
                {
                    self.cdp = [[CustomActionSheet alloc]initWithHeight:250 WithSheetTitle:@"请选择日期"];
                    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
                    
                    rightButton.tintColor = RGBACOLOR(0, 94, 196, 1);
                    UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(docancel)];
                    leftButton.tintColor = RGBACOLOR(0, 94, 196, 1);
                    
                    
                    UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
                    
                    
                    NSArray *array = [[NSArray alloc] initWithObjects:leftButton,fixedButton,rightButton,nil];
                    
                    [self.cdp.toolbar setItems: array];
                    
                    
                    
                    self.dp = [[UIDatePicker alloc]init];
                    self.dp.datePickerMode =  UIDatePickerModeDate;
                    self.dp.bounds = CGRectMake(0, 0, WIDTH_VIEW(self.view), 100);
                    
                    [self.dp addTarget:self action:@selector(datechange) forControlEvents:UIControlEventValueChanged];
                    [self.cdp addSubview:self.dp];
                  
                    [self.cdp showFromRect:CGRectMake(0, HEIGHT_VIEW(self.view)-49, WIDTH_VIEW(self.view), 49) inView:self.view animated:YES];
                    
                }
                    break;
                    
                
                case 1:
                {
                    SexViewController * sexvc = [[SexViewController alloc]init];
                    sexvc.pushFlag = 2;
                    [self.navigationController pushViewController:sexvc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
         case 4:
        {
            self.cas = [[CustomActionSheet alloc]initWithHeight:250 WithSheetTitle:@"请选择日期"];
            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(done1)];
            
            rightButton.tintColor = RGBACOLOR(0, 94, 196, 1);
            UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(docancel1)];
            leftButton.tintColor = RGBACOLOR(0, 94, 196, 1);
            
            
            UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            
            NSArray *array = [[NSArray alloc] initWithObjects:leftButton,fixedButton,rightButton,nil];
            
            [self.cas.toolbar setItems: array];
            
            //picker view;
            self.pv = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, 320, 100)];
            self.pv.delegate = self;
            self.pv.dataSource = self;
            self.pv.showsSelectionIndicator = YES;
            self.pv.tag = 1000;
            [self.pv selectRow:2 inComponent:0 animated:YES];
            [self.cas addSubview:self.pv];
            [self.cas showFromRect:CGRectMake(0, HEIGHT_VIEW(self.view)-49, WIDTH_VIEW(self.view), 49) inView:self.view animated:YES];
        }
            break;
            case 5:
        {
            self.cas = [[CustomActionSheet alloc]initWithHeight:250 WithSheetTitle:@"请选择日期"];
            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(done1)];
            
            rightButton.tintColor = RGBACOLOR(0, 94, 196, 1);
            UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(docancel1)];
            leftButton.tintColor = RGBACOLOR(0, 94, 196, 1);
            
            
            UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            
            NSArray *array = [[NSArray alloc] initWithObjects:leftButton,fixedButton,rightButton,nil];
            
            [self.cas.toolbar setItems: array];
            
            //picker view;
            self.pv = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, 320, 100)];
            self.pv.delegate = self;
            self.pv.dataSource = self;
            self.pv.showsSelectionIndicator = YES;
            self.pv.tag = 1001;
            [self.pv selectRow:2 inComponent:0 animated:YES];
            [self.cas addSubview:self.pv];
            [self.cas showFromRect:CGRectMake(0, HEIGHT_VIEW(self.view)-49, WIDTH_VIEW(self.view), 49) inView:self.view animated:YES];
        }
            break;
            case 6:
        {
            EatingViewController * eatingVC =[[EatingViewController alloc]init];
            [self.navigationController pushViewController:eatingVC animated:YES];
            
            
        }
            break;
            case 7:
        {
            CaseViewController * caseVC = [[CaseViewController alloc]init];
            [self.navigationController pushViewController:caseVC animated:YES];
            
            
        }
            break;
            case 8:
        {
            EatingHabitsViewController * ehvc = [[EatingHabitsViewController alloc]init];
            [self.navigationController pushViewController:ehvc animated:YES];
        }
            break;
            case 9:
        {
            SpecialCrowdViewController * scvc = [[SpecialCrowdViewController alloc]init];
            [self.navigationController pushViewController:scvc animated:YES];
            
            
        }
            break;
 
        default:
            break;
    }
    
}
#pragma mark actionSheet methods
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imgpicker = [[UIImagePickerController alloc]init];
    
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"点击了照相");
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
                {
                    //无权限
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设备的设置-隐私-相机中允许访问相机!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }else if(authStatus == AVAuthorizationStatusAuthorized){
                    UIImagePickerController *imgpicker = [[UIImagePickerController alloc]init];
                    imgpicker.sourceType=UIImagePickerControllerSourceTypeCamera;
                    imgpicker.allowsEditing = YES;
                    imgpicker.delegate = self;
                    [self presentViewController:imgpicker animated:YES completion:nil];
                }
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"本设备不支持相机模式" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
        }
            break;
        case 1:{
            NSLog(@"相册");
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
            {
                //无权限
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请先在隐私中设置相册权限" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
                
            }else{
                imgpicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imgpicker.allowsEditing = YES;
                imgpicker.delegate = self;
                
                [self presentViewController:imgpicker animated:YES completion:nil];
            }
        }
            break;
            
        case 2:
            NSLog(@"取消");
            [as setHidden:YES];
            break;
        default:
            break;
    }
}
#pragma mark imagePickerController methods
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0,3_0)
{
    [_imgv setImage:image] ;
    self.upload_image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [_imgv setImage:image];
    self.upload_image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
        
        self.view.frame=CGRectMake(self.view.frame.origin.x, -130, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    return YES;
}

#pragma 自定义得datepicker
-(void)done

{
    if(self.cdp.OKBtnbloack){
        self.cdp.OKBtnbloack();
    }
    [self.cdp dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)docancel

{
    [self.cdp dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)datechange
{
    NSDate *selectedDate = [self.dp date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [formatter stringFromDate:selectedDate];
 
    NSLog(@"%@",dateString);
    
    
    
}
#pragma 自定义得datepicker
-(void)done1

{
    if(self.cas.OKBtnbloack){
        self.cas.OKBtnbloack();
    }
    [self.cas dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)docancel1

{
    [self.cas dismissWithClickedButtonIndex:0 animated:YES];
}
#pragma mark Picker Datasource Protocol

//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.pv.tag == 1000) {
        return [_Arr count];
    }else
        return [_Arr1 count];
    
}

#pragma mark -
#pragma mark Picker Delegate Protocol

//设置当前行的内容
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * pickerlabel = (UILabel*)view;
    if (!pickerlabel) {
        pickerlabel = [[UILabel alloc]init];
        pickerlabel.adjustsFontSizeToFitWidth = YES;
        [pickerlabel setTextAlignment:NSTextAlignmentCenter];
        [pickerlabel setBackgroundColor:[UIColor clearColor]];
        [pickerlabel setFont:[UIFont boldSystemFontOfSize:16]];
        pickerlabel.textColor = [UIColor blackColor];
        
    }
    
    pickerlabel.text = [self pickerView:self.pv titleForRow:row forComponent:0];
    
    
    
    return pickerlabel;
    
    
    
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(self.pv.tag==1000){
        
        return [_Arr objectAtIndex:row];
    }else if(self.pv.tag==1001)
    {
        return [_Arr1 objectAtIndex:row];
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    if (self.pv.tag==1000) {
        _clan = [_Arr objectAtIndex:row];
        NSLog(@"^^^^^^^^^^^^^%@",_clan);
        [table reloadData];
    }else if(self.pv.tag==1001)
    {
        _EnucationLevel = [_Arr1 objectAtIndex:row];
        NSLog(@"**************%@",_EnucationLevel);
        [table reloadData];
    }
    
}


-(void)rightClick:(id)sender
{
    NSLog(@"right");
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
