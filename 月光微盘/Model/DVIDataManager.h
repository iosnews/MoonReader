//
//  DVIDataManager.h
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVIUser.h"

@interface DVIDataManager : NSObject

@property (nonatomic, strong) DVIUser *user;

+ (instancetype)sharedManager;

- (NSArray *)currentFileArray;
@end
