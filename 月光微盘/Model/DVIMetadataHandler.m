//
//  DVIMetadataHandler.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIMetadataHandler.h"

#import "DVIFile.h"
#import "DVIDataManager.h"

@implementation DVIMetadataHandler
- (void)handlerData:(NSData *)data  //获取用户里面保存的文件
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"%@", dict);
    DVIFile *file = [DVIFile file:dict];
    NSLog(@"%@", file);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kFetchMetadataNotification object:nil userInfo:[NSDictionary dictionaryWithObject:file forKey:kMetadataKey]];
}
@end
