//
//  NSDictionary+Utils.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "NSDictionary+Utils.h"

#import "NSString+Utils.h"

@implementation NSDictionary (Utils)

//将字典中的键值对连成字符串
- (NSString *)URLString
{
    NSMutableString *path = [NSMutableString string];
    for (NSString *key in self) {
        [path appendFormat:@"%@=%@&", key, [[self objectForKey:key] URLEncodedString]];
    }
    
    [path deleteCharactersInRange:NSMakeRange([path length] - 1, 1)];
    return path;
}
@end
