//
//  PlanViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-19.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanViewController : UIViewController<NetViewDelegate>
{
    UIView *selectView;
}

@property NSInteger PlanTag;
@property(nonatomic,retain)NSArray *DataArr;
@end
