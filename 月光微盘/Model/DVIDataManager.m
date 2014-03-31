//
//  DVIDataManager.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIDataManager.h"

#import "DVIFile.h"

@interface DVIDataManager ()
{
    NSSet *_imageSet;
}
@end

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

- (id)init
{
    if (self = [super init]) {
        _imageSet = [NSSet setWithObjects:@"png", @"jpg", @"jpeg", @"gif", nil];
    }
    
    return self;
}

- (NSArray *)currentFileArray
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    
    NSMutableArray *fileArray = [NSMutableArray array];
    for (NSString *filename in array) {
        NSString *tmpPath = [path stringByAppendingPathComponent:filename];
        NSDictionary *attr = [fileManager attributesOfItemAtPath:tmpPath error:nil];
        
        DVIFile *file = [[DVIFile alloc] init];
        file.path = filename;
        file.size = [NSString stringWithFormat:@"%lld", [attr fileSize]];
        file.modified = [NSString stringWithFormat:@"%@", [attr fileModificationDate]];
        file.mime_type = [[filename pathExtension] lowercaseString];
        
        BOOL bDirectory = NO;
        [fileManager fileExistsAtPath:tmpPath isDirectory:&bDirectory];
        if (bDirectory) {
            file.file_icon = @"icon_folder.png";
        }
        else {
            if ([_imageSet containsObject:file.mime_type]) {
                file.file_icon = @"icon_photo.png";
            }
            else {
                file.file_icon = [NSString stringWithFormat:@"icon_%@.png", file.mime_type];
            }
        }
        
        [fileArray addObject:file];
    }
    
    return fileArray;
}
@end
