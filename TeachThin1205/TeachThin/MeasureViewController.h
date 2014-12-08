//
//  MeasureViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-21.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface MeasureViewController : UIViewController<UITextFieldDelegate,NetViewDelegate,CBCentralManagerDelegate,CBPeripheralDelegate,UIAlertViewDelegate>{
    UIBarButtonItem * Fill;
    UILabel * label;
    UILabel * datelabel;
    UITextField * tf;
    UIView * tfv;
    UIButton * sureBtn;
    MenuView * menuView;
    UIButton * blueToothBtn;
    
    UILabel *InfoLable;
}
@property BOOL showMenuView;
@property (nonatomic,copy)NSString * FillDate;
@property (nonatomic,copy)NSString * today;
@property(nonatomic,copy)NSString * dateStr;

@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (strong ,nonatomic) CBCharacteristic *writeCharacteristic;

@property (strong,nonatomic) NSMutableArray *nServices;
@property (strong,nonatomic) NSMutableArray *nCharacteristics;
@property (nonatomic,strong) UITextView *InfotextView;
@property (nonatomic,strong) UITableView *deviceTable;

@property(nonatomic,retain)UIAlertView *Resultalert;
@property(nonatomic,retain)NSData *ResultData;
@property float WeightValue;
@property (nonatomic,retain)NSString *DWString;

@end
