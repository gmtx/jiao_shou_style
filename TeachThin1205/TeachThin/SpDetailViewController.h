//
//  SpDetailViewController.h
//  TeachThin
//
//  Created by 王园园 on 14-11-20.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpDetailViewController : UIViewController<UIWebViewDelegate>
{
    UIScrollView *scroll;
    UIButton *homeBtn;
    UILabel *titleLable;
    UILabel *detailLable;
    UIWebView *webview;
}

@property(nonatomic,copy)NSString *cotentStr;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *detailStr;

@end
