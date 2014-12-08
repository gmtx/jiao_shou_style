//
//  YingyangViewController.m
//  TeachThin
//
//  Created by 王园园 on 14-11-24.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "YingyangViewController.h"
#import "YDetailViewController.h"

@interface YingyangViewController ()

@end

@implementation YingyangViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"营养知识";
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
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT) collectionViewLayout:layout];
    collection.alwaysBounceVertical = NO;
    collection.backgroundColor = [UIColor brownColor];
    collection.dataSource = self;
    collection.delegate = self;
    [collection registerClass:[yingyangCell class]
   forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:collection];
    
    collection.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -80, VIEW_WEIGHT, 100)];
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(VIEW_WEIGHT/2-130, 20, 260, 35)];
    searchBar.delegate = self;
    searchBar.placeholder = @"";
    //searchBar.backgroundColor = RGBACOLOR(90., 42., 15., 1);
    searchBar.backgroundImage = [UIImage imageNamed:@"transparent"];
    [headerView addSubview:searchBar];
   [collection addSubview: headerView];

    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(VIEW_WEIGHT/2-25, VIEW_HEIGHT-60, 50, 50);
    homeBtn.backgroundColor = [UIColor purpleColor];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    homeBtn.layer.cornerRadius = 5.;
    [homeBtn addTarget:self action:@selector(HomeBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    [self SetMenuView];
}

-(void)SetMenuView
{
    MenuView = [[ListMenuView alloc]initWithFrame:CGRectMake(-100, 60, 120, self.view.frame.size.height-60)];
    [MenuView setListDataArr:@[@"营养指示",@"健康指南",@"养生指南"]];
    [MenuView setUserInteractionEnabled:YES];
    [self.view addSubview:MenuView];
    [MenuView setTapActionBlock:^(NSInteger Index) {
        NSLog(@"Taped is:%d",Index);
    }];
}


-(void)HomeBtnPress
{
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:(index-1)] animated:YES];
}


#pragma  mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
        return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    yingyangCell *cell;
    if(cell==nil){
       cell =  (yingyangCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    }
    //cell.Img = ;
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(85, 140);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2,10, 2,10);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
    NSLog(@"*******%d",indexPath.item);
    YDetailViewController *detailVC = [[YDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
