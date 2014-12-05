//
//  Macro.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#ifndef TeachThin_Macro_h
#define TeachThin_Macro_h
#import "NonetView.h"
#import "MBHUDView.h"
#import "JSHttpRequest.h"
//判断程序的版本
#define IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)


//整个屏幕的宽和高
#define VIEW_WEIGHT [UIScreen mainScreen].bounds.size.width
#define VIEW_HEIGHT (IOS_7 ?[UIScreen mainScreen].bounds.size.height :([UIScreen mainScreen].bounds.size.height-64))
#define VIEW_HEIGHT_TAB ([UIScreen mainScreen].bounds.size.height-113)

//控件的尺寸
#define WIDTH_VIEW(view) CGRectGetWidth(view.frame)
#define HEIGHT_VIEW(view) CGRectGetHeight(view.frame)
#define VIEW_MAXX(view) CGRectGetMaxX(view.frame)
#define VIEW_MAXY(view) CGRectGetMaxY(view.frame)

#define VIEW_oringeY  (IOS_7 ? 64:0)


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define GXRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

//接口
#define MAINURL @"http://www.gmtxw01.com/index.php?"

//拍一拍接口http://www.gmtxw01.com/index.php?m=product&c=index&a=food_decription&foodname=aaaa
#define URL_PhotoData(name)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=product&c=index&a=food_decription&foodname=%@",name]]
//拍一拍单品食物交换分
#define URL_JiaohuanfenData [MAINURL stringByAppendingString:[NSString stringWithFormat:@"http://www.gmtxw01.com/index.php?m=product&c=index&a=food_exchang"]]

//首页计划执行状态列表http://www.gmtxw01.com/index.php?index.php?m=hkiyun&c=plan&a=init
#define URL_MyPlanStatus  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=hkiyun&c=plan&a=init"]]
//计划详情页(post)http://www.gmtxw01.com/index.php?index.php?m=hkiyun&c=plan&a=infor
#define URL_MyPlanDetail  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=hkiyun&c=plan&a=infor"]]
//阶段计划日历状态列表http://www.gmtxw01.com/index.php?index.php?m=hkiyun&c=plan&a=details
#define URL_JDPlanDetail  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=hkiyun&c=plan&a=details"]]
//处方医嘱http://www.gmtxw01.com/index.php?index.php?m=hkiyun&c=plan&a=prescription
#define URL_PlanCFYZDetail [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=hkiyun&c=plan&a=prescription"]]
//处方医嘱http://www.gmtxw01.com/index.php?index.php?m=hkiyun&c=plan&a=advice
#define URL_PlanYZDetail [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=hkiyun&c=plan&a=advice"]]


//量一量 数据上传接口 POST
#define URL_Measure_Data  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=measure&c=index&a=measure_data"]]
//量一量 补填数据接口 GET
#define URL_Measure_Inserm(uid,year,month)[MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=measure&c=index&a=measure_inserm&uid=%@&y=%@&d=%@",uid,year,month]]
//量一量数据查看 GET
#define URL_Measure_Look(uid)[MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=measure&c=index&a=measure_look&uid=%@",uid]]
//量一量根据日期查看 GET
#define URL_Measure_Date(uid,starttime)[MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=measure&c=index&a=measure_date&uid=%@&starttime=%@",uid,starttime]]

//每日食谱
//数据查看 post
#define URL_Recipes_recipes  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=recipes&c=recipess&a=recipes"]]
//计划执行 post
#define URL_Recipes_plan  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=recipes&c=recipess&a=plan"]]
//计划不执行 post
#define URL_Recipes_noplan  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"m=recipes&c=recipess&a=noplan"]]
#endif
