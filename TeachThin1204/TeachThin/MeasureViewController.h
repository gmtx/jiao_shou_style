//
//  MeasureViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-21.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"
@interface MeasureViewController : UIViewController<UITextFieldDelegate,NetViewDelegate>{
    UIBarButtonItem * Fill;
    UILabel * label;
    UILabel * datelabel;
    UITextField * tf;
    UIButton * sureBtn;
    MenuView * menuView;
    UIButton * blueToothBtn;
    
  
    
}
@property BOOL showMenuView;
@property (nonatomic,copy)NSString * FillDate;
@property (nonatomic,copy)NSString * today;
@property(nonatomic,copy)NSString * dateStr;
//@property(nonatomic,strong)CustomActionSheet * cas;
//@property(nonatomic,strong)UIView * contentView;
//@property(strong, nonatomic) UIView *titleView;
@end
