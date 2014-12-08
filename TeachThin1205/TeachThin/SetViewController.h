//
//  SetViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14/11/13.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "CustomActionSheet.h"

@interface SetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITableView * table;
    UITextField * tf1;
    UITextField * tf2;
    UIActionSheet * as;
}
@property(nonatomic,strong)NSArray * arr;
@property(nonatomic,strong)UILabel * celltitle;
@property(nonatomic,strong)UILabel * cellcontent;
@property(nonatomic,strong)UIImageView * imgv;
@property (nonatomic,strong)UILabel * sexlabel;
@property (nonatomic,strong)UILabel * birthdayLable;
@property (retain,nonatomic)UIImage * upload_image; //上传图片
@property (retain,nonatomic)NSString *image_name; //图片的名字
@property(nonatomic,strong)CustomActionSheet * cdp;
@property (nonatomic,retain)UIDatePicker * dp;

@property(nonatomic,strong)CustomActionSheet * cas;
@property(nonatomic,strong)UIPickerView * pv;
@property(nonatomic,strong)NSArray * Arr;
@property(nonatomic,strong)NSArray * Arr1;
@property(nonatomic,copy)NSString * clan;
@property(nonatomic,copy)NSString * EnucationLevel;
@property(nonatomic,copy)NSString * actstrength;
@property(nonatomic,copy)NSString * eating;
@property(nonatomic,copy)NSString * case1;
@property(nonatomic,copy)NSString * allergy;
@property(nonatomic,copy)NSString * special;
@property(nonatomic,copy)NSString * userSex;

@end
