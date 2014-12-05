//
//  CustomActionSheet.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-14.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomActionSheet : UIActionSheet
{
    UIToolbar* toolBar;
   
}

@property(nonatomic,strong)UIToolbar*toolbar;
@property(nonatomic,strong)UIView * contentView;
@property(nonatomic,strong)void (^OKBtnbloack)(void);
-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title;

@end
