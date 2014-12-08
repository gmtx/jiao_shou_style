//
//  CustomActionSheet.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-14.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "CustomActionSheet.h"

@implementation CustomActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title

{
    
    self = [super init];
    
    if (self)
        
    {

        int theight = height - 40;
        
        int btnnum = theight/50;
        
        for(int i=0; i<btnnum; i++)
            
        {
            [self addButtonWithTitle:@""];
            
        }
        
        self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [self.toolbar setTintColor:RGBACOLOR(22., 122., 206., 1)];
        self.toolbar.barStyle = UIBarStyleDefault;
        
        [self.toolbar setTintColor:[UIColor darkGrayColor]];
        
        [self addSubview:self.toolbar];
        
        
        
       _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, height-40)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.userInteractionEnabled  = YES;
        [self addSubview:_contentView];
        
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
