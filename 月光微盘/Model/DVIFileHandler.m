//
//  DVIFileHandler.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-30.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIFileHandler.h"

@implementation DVIFileHandler
- (void)handlerData:(NSData *)data
{
    NSString *filename = [NSString stringWithFormat:@"%@/Documents%@", NSHomeDirectory(), self.path];
    
    NSString *directory = [filename stringByDeletingLastPathComponent];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:directory]) {
        [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    BOOL bWrite = [data writeToFile:filename atomically:YES];
    if (bWrite) {
        NSLog(@"....OK");
    }
    
    NSDictionary *dict = @{ kFileNameKey : filename,
                            kFileTypeKey : [filename pathExtension] };
    [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadFileNotification object:nil userInfo:dict];
}
@end
