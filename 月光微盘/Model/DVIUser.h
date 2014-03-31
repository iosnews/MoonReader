//
//  DVIUser.h
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVIUser : NSObject

@property (nonatomic, copy) NSString *avatar_large;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *profile_image_url;
@property (nonatomic, strong) NSDictionary *quota_info;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *sina_uid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, assign) BOOL verified;

- (id)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)user:(NSDictionary *)dict;

@end
