//
//  DVIDataHandler.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIDataHandler.h"

@implementation DVIDataHandler
- (void)handlerData:(NSData *)data
{

    [self doesNotRecognizeSelector:_cmd];  //当子类没有实现时，调用该方法报错，子类必须实现该方法
}
@end
