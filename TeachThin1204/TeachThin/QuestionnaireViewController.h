//
//  QuestionnaireViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomActionSheet.h"
@interface QuestionnaireViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITableView * table;
    UIView * header;
    UIView * footer;
    UIButton * sureBtn;
}
@property(nonatomic,strong)UILabel * celltitle;
@property(nonatomic,strong)UILabel * cellcontent;
@property(nonatomic,strong)CustomActionSheet * cas;
@property(nonatomic,strong)NSArray * Arr;
@property(nonatomic,strong)UIPickerView * pv;
@property(nonatomic,copy)NSString * clan;
@property(nonatomic,strong)NSArray * Arr1;
@property(nonatomic,copy)NSString * EnucationLevel;
@property(nonatomic,copy)NSString * actstrength;
@property(nonatomic,copy)NSString * eating;
@property(nonatomic,copy)NSString * case1;
@property(nonatomic,copy)NSString * allergy;
@property(nonatomic,copy)NSString * special;

@end
