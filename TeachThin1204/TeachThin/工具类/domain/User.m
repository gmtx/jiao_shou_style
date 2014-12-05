//
//  User.m
//  styler
//
//  Created by System Administrator on 13-5-15.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//


#import "User.h"
@implementation User

-(NSString *)genderTxt{
    if(self.gender == gender_male){
        return @"男";
    }
    return @"女";
}


-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.idStr forKey:@"id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.avatarUrl forKey:@"avatarUrl"];
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.loginMobileNo forKey:@"loginMobileNo"];
    [aCoder encodeObject:self.easemobUserUuid forKey:@"easemobUserUuid"];
    [aCoder encodeObject:self.userCode forKey:@"userCode"];
    
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    
    if(self){
        self.idStr = [aDecoder decodeObjectForKey:@"id"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.gender = [aDecoder decodeIntForKey:@"gender"];
        self.avatarUrl = [aDecoder decodeObjectForKey:@"avatarUrl"];
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.loginMobileNo = [aDecoder decodeObjectForKey:@"loginMobileNo"];
        self.easemobUserUuid = [aDecoder decodeObjectForKey:@"easemobUserUuid"];
        self.userCode = [aDecoder decodeObjectForKey:@"userCode"];
    }
    
    return self;
}

- (void) readFromJSONDictionary:(NSDictionary *)jsonDict{
    [self setIdStr:[jsonDict objectForKey:@"id"]];
    [self setName:[jsonDict objectForKey:@"name"]];
    [self setGender:[[jsonDict objectForKey:@"userGender"] intValue]];
    [self setAccessToken:[jsonDict objectForKey:@"accessToken"]];
    [self setLoginMobileNo:[jsonDict objectForKey:@"loginMobileNo"]];
    [self setEasemobUserUuid:[jsonDict objectForKey:@"easemobUserUuid"]];
    [self setUserCode:[jsonDict objectForKey:@"userCode"]];
    [self setAvatarUrl:[jsonDict objectForKey:@"avatarUrl"]];
}

-(User *) copyWithZone:(NSZone *)zone{
    User *user = [[User allocWithZone:zone] init];
    
    user.idStr = self.idStr;
    user.name = self.name;
    user.gender = self.gender;
    user.accessToken = self.accessToken;
    user.loginMobileNo = self.loginMobileNo;
    user.easemobUserUuid = self.easemobUserUuid;
    user.userCode = self.userCode;
    user.avatarUrl = self.avatarUrl;
    
    return user;
}


-(NSString *) description{
    return [NSString stringWithFormat:@"id:%@, name:%@, accessToken:%@, moblieNo:%@", self.idStr, self.name, self.accessToken, self.loginMobileNo];
}

@end
