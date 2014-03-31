//
//  DVIToken.h
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVIToken : NSObject <NSCoding>
@property (nonatomic, copy) NSString    *access_token;
@property (nonatomic, assign) long      expires_in;
@property (nonatomic, copy) NSString    *refresh_token;
@property (nonatomic, assign) long      time_left;

+ (instancetype)token:(NSDictionary *)dict;
+ (instancetype)localToken;

- (void)saveToken;
@end
