//
//  AppStatus.m
//  styler
//
//  Created by System Administrator on 13-5-13.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "AppStatus.h"
#import "EaseMobProcessor.h"

@implementation AppStatus

-(NSString *) ua{
    NSMutableString *ua = [[NSMutableString alloc] init];
    [ua appendFormat:@"ios,%@", [[UIDevice currentDevice] systemVersion]];
    [ua appendFormat:@";%@,%d*%d",[[UIDevice currentDevice] model],  (int)[[UIScreen mainScreen] bounds].size.width,  (int)[[UIScreen mainScreen]bounds].size.height];
    
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    [ua appendFormat:@";%@,%@", [dicInfo objectForKey:@"CFBundleName"], [dicInfo objectForKey:@"CFBundleShortVersionString"]];
    [ua appendFormat:@";%@", self.deviceToken==nil?@"unknow":self.deviceToken];
    //[ua appendFormat:@";%f,%f", self.lastLng, self.lastLat];
    return ua;
}

//是否登录
-(BOOL) logined{
    if(self.user != nil && self.user.accessToken != nil && (NSNull *)self.user.accessToken != [NSNull null])
        return YES;
    return NO;
}

-(float)iosVersion{
   return [[[UIDevice currentDevice] systemVersion] floatValue];
}

-(NSString *)appVersion{
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    return [dicInfo objectForKey:@"CFBundleShortVersionString"];
}

-(void) removeStylerUA{
    NSDictionary *registeredDefaults = [[NSUserDefaults standardUserDefaults] volatileDomainForName:NSRegistrationDomain];
    if ([registeredDefaults objectForKey:@"UserAgent"] != nil) {
        //NSLog(@">>>>>>> before remove styler ua:%@", [registeredDefaults objectForKey:@"UserAgent"]);
        NSMutableDictionary *mutableCopy = [NSMutableDictionary dictionaryWithDictionary:registeredDefaults];
        [mutableCopy removeObjectForKey:@"UserAgent"];
        [[NSUserDefaults standardUserDefaults] setVolatileDomain:[mutableCopy copy] forName:NSRegistrationDomain];
    }
}

-(void) setStylerUA{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[self ua], @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeDouble:self.lastLat forKey:@"lastLat"];
    [aCoder encodeDouble:self.lastLng forKey:@"lastLng"];
    [aCoder encodeObject:self.currentLocation forKey:@"currentLocation"];
    [aCoder encodeObject:self.deviceToken forKey:@"deviceToken"];
    [aCoder encodeObject:self.user forKey:@"user"];


}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        self.lastLat = [aDecoder decodeDoubleForKey:@"lastLat"];
        self.lastLng = [aDecoder decodeDoubleForKey:@"lastLng"];
        self.currentLocation = [aDecoder decodeObjectForKey:@"currentLocation"];
        self.deviceToken = [aDecoder decodeObjectForKey:@"deviceToken"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
    }
    
    return self;
}

+(void) saveAppStatus{
    //NSLog(@"AppStatus to be saving:%@", [AppStatus sharedInstance].description);
    [NSKeyedArchiver archiveRootObject:[AppStatus sharedInstance] toFile:[AppStatus savedPath]];
}

+(NSString *) savedPath{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    documentDirectory = [documentDirectory stringByAppendingPathComponent:@"appStatus.archive"];
    return documentDirectory;
}

+(AppStatus *)sharedInstance{
    static AppStatus *sharedInstance = nil;
    if(sharedInstance == nil){
        NSString *path = [AppStatus savedPath];
        sharedInstance = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if(sharedInstance == nil){
            
        }
        
        NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
        sharedInstance.easemobApnsCertName = [dicInfo objectForKey:@"easemobApnsCertName"];
        sharedInstance.easemobAppKey = [dicInfo objectForKey:@"easemobAppKey"];
       
    }
    
    return sharedInstance;
}

-(NSString *) description{
    return [NSString stringWithFormat:@"deviceToken:%@, user:%@, lastLat:%f, lastLng:%f", self.deviceToken, self.user
            .description, self.lastLat, self.lastLng];
}

@end
