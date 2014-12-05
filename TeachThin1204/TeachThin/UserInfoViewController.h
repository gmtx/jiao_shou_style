//
//  UserInfoViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "CustomActionSheet.h"



@interface UserInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UITableView * table;
    UIView * header;
    UIButton * imgvBtn;
    UITextField * tf1,*tf2,*tf3;
    
    UIView * footer;
    UIButton * sureBtn;
    UIActionSheet * as;    
    
}
@property(nonatomic,strong)NSArray * arr;
@property(nonatomic,strong)UILabel * celltitle;
@property(nonatomic,strong)UILabel * cellcontent;
@property (retain,nonatomic)UIImage * upload_image; //上传图片
@property (retain,nonatomic)NSString *image_name; //图片的名字
@property(nonatomic,strong)CustomActionSheet * cdp;
@property (nonatomic,strong)UIDatePicker * dp;
@property (nonatomic,copy)NSString * userSex;
@property (nonatomic,copy)NSString * userBirthday;
@end
