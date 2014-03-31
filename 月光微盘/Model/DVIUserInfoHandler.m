//
//  DVIUserInfoHandler.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIUserInfoHandler.h"

#import "DVIUser.h"
#import "DVIDataManager.h"

@implementation DVIUserInfoHandler


//处理用户信息相关的数据

- (void)handlerData:(NSData *)data  //获取用户信息

{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    DVIUser *user = [DVIUser user:dict];
    NSLog(@"%@", user);
    
    [DVIDataManager sharedManager].user = user;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kFetchUserInfoNotification object:nil userInfo:[NSDictionary dictionaryWithObject:user forKey: kUserInfoKey]];
}
@end
