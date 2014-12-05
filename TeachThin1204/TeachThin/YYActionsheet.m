//
//  YYActionsheet.m
//  TeachThin
//
//  Created by 王园园 on 14-11-27.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "YYActionsheet.h"

@implementation YYActionsheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title

{
    
    self = [super init];
    
    if (self)
        
    {
        int theight = height - 40;
        
        int btnnum = theight/50;
        
        for(int i=0; i<btnnum; i++)
            
        {
            [self addButtonWithTitle:@" "];
            
        }
        
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        toolBar.barStyle = UIBarStyleDefault;
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
        
        
        UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(docancel)];
        
        
        UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        
        NSArray *array = [[NSArray alloc] initWithObjects:leftButton,fixedButton,rightButton,nil];
        
        [toolBar setTintColor:RGBACOLOR(22., 122., 206., 1)];
        [toolBar setItems: array];
        [self addSubview:toolBar];
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, height-44)];
        
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        
//        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 68, VIEW_WEIGHT, 37)];
//        backView.backgroundColor = RGBACOLOR(255., 160., 68., 1);
//        [view addSubview:backView];
        
        [self addSubview:view];
        
        //    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //    cancelBtn.frame = CGRectMake(10, 5, 40, 40);
        //    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        //    [cancelBtn addTarget:self action:@selector(CancelBtnPress) forControlEvents:UIControlEventTouchUpInside];
        //    [positionView addSubview:cancelBtn];
        //
        //    UIButton *OkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //    OkBtn.frame = CGRectMake(10, VIEW_WEIGHT-50, 40, 40);
        //    [OkBtn setTitle:@"确定" forState:UIControlStateNormal];
        //    [OkBtn addTarget:self action:@selector(OkBtnPress) forControlEvents:UIControlEventTouchUpInside];
        //    [positionView addSubview:OkBtn];
        
    }
    return self;
}


-(void)done

{
    if(self.OKBtnbloack){
        self.OKBtnbloack();
    }
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)docancel

{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

@end
