//
//  DVIUser.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIUser.h"

@implementation DVIUser


- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
	    
    return self;
}

+ (instancetype)user:(NSDictionary *)dict
{
    return [[DVIUser alloc] initWithDictionary:dict];
    NSLog(@"yangpin son");
}
@end
