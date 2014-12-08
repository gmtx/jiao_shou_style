//
//  JSHttpRequest.m
//  TeachThin
//
//  Created by 王园园 on 14-11-26.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//

#import "JSHttpRequest.h"

@implementation JSHttpRequest

//将urlstr UTF8编码
-(NSString *)getEncodeurlStr:(NSString *)urlstr;
{
    NSString *encodeurlstr =  [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodeurlstr;
}

-(void)StartWorkWithUrlstr:(NSString *)str;
{
    //状态栏旁边的菊花指示器转动
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperationManager *manager =  [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:[self getEncodeurlStr:str] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(_successGetData){
            self.successGetData(responseObject);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(_failureGetData){
            self.failureGetData();
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

-(void)StartWorkPostWithurlstr:(NSString *)str pragma:(NSDictionary *)dict ImageData:(NSData *)data;
{
    //状态栏旁边的菊花指示器转动
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:str  parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(data==nil) ;else{
            [formData appendPartWithFileData:data name:@"picurl" fileName:@"defult_placeImage.png" mimeType:@"png"];
        }
    }success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(_successGetData){
            self.successGetData(responseObject);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(_failureGetData){
            self.failureGetData();
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}


@end
