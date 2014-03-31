//
//  NSString+Utils.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)


//进行URL编码
- (NSString *)URLEncodedString {
    
	return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}

- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding {
    
	return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)[self mutableCopy],
                                                                                 NULL,
                                                                                 CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"),
                                                                                 encoding));
}

//URL解码
- (NSString *)URLDecodedString {
    
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

@end
