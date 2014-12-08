//
//  RaiseMeViewController.h
//  TeachThin
//
//  Created by 巩鑫 on 14-11-14.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASValueTrackingSlider.h"
@interface RaiseMeViewController : UIViewController<ASValueTrackingSliderDataSource>
{
    UIImageView *backPeopleImg;
    UIImageView *peopleImg;
}
@property(nonatomic,retain) ASValueTrackingSlider *slider;
@end
