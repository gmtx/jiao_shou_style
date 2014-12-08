//
//  ShopViewController.m
//  TeachThin
//
//  Created by 巩鑫 on 14/11/12.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopCell.h"
#import "ShopDetailViewController.h"
@interface ShopViewController ()

@end

@implementation ShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"食物配送";
        UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"购物车" style:UIBarButtonItemStylePlain target:self action:@selector(RightClick:)];
        self.navigationItem.rightBarButtonItem = right;
    }
    return self;
}

-(void)RightClick:(id)sender
{
    NSLog(@"right");
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setlayout];
}
-(void)setlayout
{
    //实例化搜索栏
    
    _searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, WIDTH_VIEW(self.view), 40)];
    _searchbar.barStyle = UISearchBarStyleDefault;
    _searchbar.delegate = self;
    _searchbar.placeholder = @"请输入关键字";
    _searchbar.keyboardType = UIKeyboardAppearanceDefault;
    _searchbar.tintColor = [UIColor lightGrayColor];
    /////////////更换搜索框背景图片
    for (UIView *subview in _searchbar.subviews)
    {
        if ([subview isKindOfClass: NSClassFromString(@"UISearchBarBackground")])
        {
            [subview removeFromSuperview];
            break;
        }
    }
   
    
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [topView setItems:buttonsArray];
    [ _searchbar setInputAccessoryView:topView];
    
    [self.view addSubview:_searchbar];
    
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,104,WIDTH_VIEW(self.view), HEIGHT_VIEW(self.view)) collectionViewLayout:layout];
    collection.alwaysBounceVertical = YES;
    collection.backgroundColor = [UIColor clearColor];
    
    [collection registerClass:[ShopCell class]
   forCellWithReuseIdentifier:@"Cell"];
    collection.dataSource = self;
    collection.delegate = self;
    collection.scrollEnabled = YES;
    [collection reloadData];
    [self.view addSubview:collection];
    
    
}

#pragma  mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return 9;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ShopCell * cell =  (ShopCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = GXRandomColor;
    cell.cellimg.backgroundColor = GXRandomColor;

    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90,150);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10, 10,10);
}

#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopDetailViewController * sdvc = [[ShopDetailViewController alloc]init];
    [self.navigationController pushViewController:sdvc animated:YES];
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)dismissKeyBoard{
    [_searchbar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchBar.text length] == 0) {
		return;
	}else{
        [collection reloadData];
        
    }
}


#pragma Searcherbar Delegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
   [_searchbar resignFirstResponder];
    _searchbar.showsCancelButton = NO;

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString * str = [NSString stringWithFormat:@"%@",searchBar.text];
    NSLog(@"%@",str);
    [searchBar resignFirstResponder];
    [collection reloadData];
}

//更改cancel按钮文字
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    for(id cc in searchBar.subviews)
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_searchbar resignFirstResponder];
    
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
