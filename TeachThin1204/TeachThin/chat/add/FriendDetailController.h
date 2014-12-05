//
//  FriendDetailController.h
//  TeachThin
//
//  Created by myStyle on 14-11-27.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendDetailView.h"
@interface FriendDetailController : UIViewController
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) FriendDetailView *friendDetailView;
@end
