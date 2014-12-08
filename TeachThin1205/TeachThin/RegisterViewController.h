//
//  RegisterViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-13.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
{
    
    UIBarButtonItem * right;
    UILabel * line1;
    UILabel * line2;
    UITextField * tf1;
    UITextField * tf2;
    UIButton * sendBtn;
    UIImageView * imgv;
    
    UILabel * line3;
    UIButton * timebtn;
}
@property BOOL summit;
@end
