//
//  QuestionnaireViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "QuestionnaireViewController.h"
#import "EatingViewController.h"
#import "EatingHabitsViewController.h"
#import "CaseViewController.h"
#import "ActStrengthViewController.h"
#import "SpecialCrowdViewController.h"
@interface QuestionnaireViewController ()

@end

@implementation QuestionnaireViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"调查问卷";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(actStrength:) name:@"actStrength" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(eating:) name:@"eating" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(case1:) name:@"case" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allergy:) name:@"allergy" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(special:) name:@"special" object:nil];
    
    
}
-(void)actStrength:(NSNotification*)notification
{
    
    id obj = [notification object];
    NSLog(@"劳动强度的数据数组是%@",obj);
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:obj, nil];
    NSMutableArray * arr1 = [arr objectAtIndex:0];
    _actstrength = [arr1 componentsJoinedByString:@","];
    NSLog(@"&&&&&&&&&&&&&&%@",_actstrength);
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
    _Arr = [[NSArray alloc]initWithObjects:@"汉族",@"壮族",@"满族",@"回族",@"苗族",@"维吾尔族",@"土家族",@"彝族",@"蒙古族",@"藏族",@"布依族",@"朝鲜族",@"瑶族", nil];
    _Arr1 = [[NSArray alloc]initWithObjects:@"小学",@"初中",@"高中",@"大专",@"本科",@"研究生",@"硕士",@"博士", nil];
    [self setlayout];
    
}
-(void)setlayout

{
    
    header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 20)];
    
    
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 20, WIDTH_VIEW(self.view)-40, 40);
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
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
#pragma table delegate;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
   
    
    UITableViewCell *cell =(UITableViewCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    UILabel *lable = (UILabel *)[cell viewWithTag:1000];
    if (CGRectGetHeight(lable.frame)>24) {
        return CGRectGetHeight(lable.frame)+20;
    }
    else return 44;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 9;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section==1) {
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
        
        _celltitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, WIDTH_VIEW(cell.contentView)/4, 36)];
        _celltitle.textAlignment = NSTextAlignmentCenter;
        _celltitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        _celltitle.textColor = [UIColor blackColor];
        [cell.contentView addSubview:_celltitle];
        
        _cellcontent = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_MAXX(_celltitle)+20, 4, WIDTH_VIEW(self.view)/2, 36)];
     
        [cell.contentView addSubview:_cellcontent];
    
    }
   
    
    
    
    switch (indexPath.section) {
        case 0:
        {
            _celltitle.text = @"民族";
            if (_clan!=nil) {
                _cellcontent.text = [NSString stringWithFormat:@"%@",_clan];
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                      _celltitle.text = @"文化程度";
                    if (_EnucationLevel!=nil) {
                        _cellcontent.text = [NSString stringWithFormat:@"%@",_EnucationLevel];
                    }
                }
                    break;
                    case 1:
                {
                    _celltitle.text = @"劳动强度";
              
                    if(_actstrength!=nil){
                        _cellcontent.text = _actstrength;
                        NSLog(@"&&&&&&&&&&&&&&%@",_actstrength);                    }
                   
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
             case 2:
        {
            _celltitle.text = @"饮食偏好";
            if (_eating!=nil) {
                _cellcontent.text = _eating;
            }
           
        }
            break;
            case 3:
        {
            _celltitle.text = @"病史";
            if (!_case1) {
                _cellcontent.text = _case1;
            }
        }
            break;
            case 4:
        {
             _celltitle.text = @"过敏源";
            if (!_allergy) {
                _cellcontent.text = _allergy;
            }
        }
            break;
            case 5:
        {
             _celltitle.text = @"特殊人群";
            if (!_special) {
                _cellcontent.text = _special;
            }
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            self.cas = [[CustomActionSheet alloc]initWithHeight:250 WithSheetTitle:@"请选择日期"];
            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
            
            rightButton.tintColor = RGBACOLOR(0, 94, 196, 1);
            UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(docancel)];
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
            case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    self.cas = [[CustomActionSheet alloc]initWithHeight:250 WithSheetTitle:@"请选择日期"];
                    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
                    
                    rightButton.tintColor = RGBACOLOR(0, 94, 196, 1);
                    UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(docancel)];
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
                    case 1:
                {
                    ActStrengthViewController * asvc = [[ActStrengthViewController alloc]init];
                    [self.navigationController pushViewController:asvc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            case 2:
        {
            EatingViewController * eatingVC =[[EatingViewController alloc]init];
            [self.navigationController pushViewController:eatingVC animated:YES];
        }
            break;
            case 3:
        {
            CaseViewController * caseVC = [[CaseViewController alloc]init];
            [self.navigationController pushViewController:caseVC animated:YES];
        }
            break;
            case 4:
        {
         
            EatingHabitsViewController * ehvc = [[EatingHabitsViewController alloc]init];
            [self.navigationController pushViewController:ehvc animated:YES];
            
            
        }
            break;
            case 5:
        {
            SpecialCrowdViewController * scvc = [[SpecialCrowdViewController alloc]init];
            [self.navigationController pushViewController:scvc animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma 自定义得datepicker
-(void)done

{
    if(self.cas.OKBtnbloack){
        self.cas.OKBtnbloack();
    }
    [self.cas dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)docancel

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






-(void)sureBtnClick:(id)sender
{
    NSLog(@"sure");
   
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
