//
//  DVIFile.h
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVIFile : NSObject

@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *rev;
@property (nonatomic, assign) BOOL thumb_exists;
@property (nonatomic, copy) NSString *bytes;
@property (nonatomic, copy) NSString *modified;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, assign) BOOL is_dir;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *root;
@property (nonatomic, copy) NSString *mime_type;
@property (nonatomic, copy) NSString *revision;
@property (nonatomic, copy) NSString *md5;
@property (nonatomic, copy) NSString *sha1;
@property (nonatomic, copy) NSString *hash;
@property (nonatomic, assign) BOOL is_deleted;
@property (nonatomic, copy) NSArray *contents;
@property (nonatomic, copy) NSString *file_icon;

- (id)initWithDict:(NSDictionary *)dict;
+ (instancetype)file:(NSDictionary *)dict;
@end
