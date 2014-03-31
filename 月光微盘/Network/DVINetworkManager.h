//
//  DVINetworkManager.h
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVINetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchUserInfo;
- (void)fetchMetadata:(NSString *)path;
- (void)downloadFile:(NSString *)path;
- (void)putFile:(NSString *)localPath toPath:(NSString *)remotePath;
- (void)postFile:(NSString *)localPath toPath:(NSString *)remotePath;
@end
