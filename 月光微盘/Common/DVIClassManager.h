//
//  DVIClassManager.h
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVIClassManager : NSObject
+ (instancetype)sharedManager;

- (NSString *)classNameForKey:(NSString *)key;
@end
