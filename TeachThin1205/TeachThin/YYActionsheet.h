//
//  YYActionsheet.h
//  TeachThin
//
//  Created by 王园园 on 14-11-27.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYActionsheet : UIActionSheet
{
    
    UIToolbar* toolBar;
    
    UIView* view;
    
}

@property(nonatomic,strong)void (^OKBtnbloack)(void);
-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title;

@end
