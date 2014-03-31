//
//  DVIClassManager.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIClassManager.h"

@interface DVIClassManager ()
{
    NSDictionary *_classDictionary;
}
@end

@implementation DVIClassManager
+ (instancetype)sharedManager
{
    static DVIClassManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DVIClassManager alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    if (self = [super init]) {               //在字典中把类名通过key 存进去
        _classDictionary = @{kWeipanUserInfoURL: @"DVIUserInfoHandler",
                             kWeipanMetadataURL: @"DVIMetadataHandler",
                             kWeipanFileURL: @"DVIFileHandler"};
    
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"class" ofType:@"plist"];
//        _classDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    return self;
}

- (NSString *)classNameForKey:(NSString *)key
{
    return [_classDictionary objectForKey:key];
}
@end
