//
//  MyFamilyViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-14.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "MyFamilyViewController.h"
#import "FamilyDetailViewController.h"

#define originalHeight 60.0f
#define newHeight 110.0f
#define isOpen @"110.0f"
#define KEY [NSString stringWithFormat:@"%i",indexPath.section]

@interface MyFamilyViewController ()

@end

@implementation MyFamilyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的家人";
        self.view.backgroundColor = [UIColor whiteColor];
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
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLayout];
}


-(void)setLayout
{
#pragma mark  - table
    _count = 0;
    _mHeight = originalHeight;
    _sectionIndex = 0;
    _dicClicked = [[NSMutableDictionary alloc]initWithCapacity:3];
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_table];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mrk -
#pragma mark - UItableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *contentIndentifer = @"Container";
     UINib *nib=[UINib nibWithNibName:@"familyCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:contentIndentifer];
    familyCell *cell ;
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"familyCell" owner:self options:nil] lastObject];
        cell.layer.masksToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.MoreBtn.userInteractionEnabled = NO;
        cell.MoreBtn.tag = indexPath.section;
        [cell.MoreBtn addTarget:self action:@selector(MoreBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    //详细信息点击跳转
    cell.BtntapMethed = ^(NSInteger tag){
        if(tag==3){
            FamilyDetailViewController *detailVC3 = [[FamilyDetailViewController alloc]init];
            //传值
            [self.navigationController pushViewController:detailVC3 animated:YES];
        }
    };
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
    if (targetCell.frame.size.height < newHeight){
        
        [_dicClicked setObject:isOpen forKey:KEY];
    }
    else{
        [_dicClicked removeObjectForKey:KEY];
    }
    [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[_dicClicked objectForKey:KEY] isEqualToString: isOpen])
        return newHeight;
    else
        return originalHeight;
}

//设置单元格的可编辑状态
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//编辑单元格所执行的操作
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
    //删除数据
}


-(void)MoreBtnPress:(UIButton *)btn
{
    
}

@end
