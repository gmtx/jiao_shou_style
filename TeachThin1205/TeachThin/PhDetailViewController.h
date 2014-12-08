//
//  PhDetailViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhDetailViewController : UIViewController<UITextFieldDelegate>
{
    UIImageView *imgView;
    UITextField *nameTextField;
}

@property(nonatomic,strong)UIImage *TakeImg;
@property NSInteger foodType;

@end
