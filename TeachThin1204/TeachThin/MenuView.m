//
//  MenuView.m
//  TeachThin
//
//  Created by 巩鑫 on 14-11-26.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView * imgv = [[UIImageView alloc]init];
        imgv.frame = CGRectMake(WIDTH_VIEW(self)-14, 4, 14, 6);
        imgv.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Triangle"]];
        [self addSubview:imgv];
        [self addSubview:[self addtable]];
    
    }
    return self;
}
-(UITableView*)addtable
{
    
    
    
    if(!table){
        table = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, self.frame.size.height-10) style:UITableViewStylePlain];
        table.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
        table.delegate = self;
        table.dataSource = self;
        table.rowHeight = 40.f;
        table.scrollEnabled = NO;
        [table setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
 
    return table;
}
-(void)ocurMenuView
{
    table.alpha = 1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.frame=CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}


-(void)hidenMenuView
{
    self.hidden = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.frame=CGRectMake(self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = @[@"补填",@"趋势图"];
    NSString *Identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    UILabel *lable;
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
        lable.textColor = [UIColor whiteColor];
        lable.font = [UIFont boldSystemFontOfSize:15.];
        lable.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lable];
    }
    lable.text = [NSString stringWithFormat:@"%@",arr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hidenMenuView];
    if(self.TapActionBlock){
        self.TapActionBlock(indexPath.row);
    }
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
