//
//  DVIFile.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIFile.h"

@implementation DVIFile
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        for (NSString *key in dict) {
            //如果是目录，需要将其下面的所有文件或者文件夹的信息也转换为DVIFile的对象
            if ([key isEqualToString:@"contents"]) {
                NSMutableArray *array = [NSMutableArray array];
                
                for (NSDictionary *file in [dict objectForKey:@"contents"]) {  //如果是字典则进去里面把内容去出来
                                                                        //后面取的时候 .contents. 取内容
                    DVIFile *f = [[DVIFile alloc] initWithDict:file];
                    [array addObject:f];
                }
                
                [self setValue:array forKey:key];
            }
            else {
                [self setValue:[dict objectForKey:key] forKey:key];
            }
        }
    }
    
    return self;
}

+ (instancetype)file:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
