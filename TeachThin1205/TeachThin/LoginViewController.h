//
//  LoginViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-13.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXTextField.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate,NetViewDelegate>
{
    UIImageView * imgv;
    GXTextField * tf1;
    UIImageView * imgv1;
    GXTextField* tf2;
    UIImageView * imgv2;
    UIButton * loginBtn;
    UIButton * RegisterBtn;
    UIButton * ForgetBtn;
}
@property(nonatomic,copy)NSString * userName;
@property(nonatomic,copy)NSString * passWord;
@end
