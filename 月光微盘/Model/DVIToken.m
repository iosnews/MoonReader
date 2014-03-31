//
//  DVIToken.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIToken.h"

#define kAccessTokenKey     @"access_token"
#define kExpiresKey         @"expires_in"
#define kRefreshTokenKey    @"refresh_token"
#define kTimeLeftKey        @"time_left"

@implementation DVIToken
+ (instancetype)token:(NSDictionary *)dict
{
    DVIToken *t = [[DVIToken alloc] init];
    t.access_token = [dict objectForKey: kAccessTokenKey];
    t.expires_in = [[dict objectForKey: kExpiresKey] longValue];
    t.refresh_token = [dict objectForKey: kRefreshTokenKey];
    t.time_left = [[dict objectForKey: kTimeLeftKey] longValue];
    
    return t;
}

+ (instancetype)localToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  
    NSData *data = [userDefaults objectForKey:kAccessTokenInfoKey];
    if (!data) {
        return nil;
    }
    
    DVIToken *token = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return token;
}

- (void)saveToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self] forKey:kAccessTokenInfoKey];
    [userDefaults synchronize];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {                 
        self.access_token = [aDecoder decodeObjectForKey:kAccessTokenKey];
        self.expires_in = [aDecoder decodeIntegerForKey:kExpiresKey];
        self.refresh_token = [aDecoder decodeObjectForKey:kRefreshTokenKey];
        self.time_left = [aDecoder decodeIntegerForKey:kTimeLeftKey];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:kAccessTokenKey];
    [aCoder encodeInteger:self.expires_in forKey:kExpiresKey];
    [aCoder encodeObject:self.refresh_token forKey:kRefreshTokenKey];
    [aCoder encodeInteger:self.time_left forKey:kTimeLeftKey];
}
@end
