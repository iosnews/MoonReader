//
//  DVIDataManager.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIDataManager.h"

@implementation DVIDataManager
+ (instancetype)sharedManager
{
    static DVIDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DVIDataManager alloc] init];
    });
    
    return sharedInstance;
}
@end
