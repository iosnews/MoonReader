//
//  DVIHttpRequest.h
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DVIHttpRequest;

@protocol DVIHttpRequestDelegate <NSObject>

@optional
- (void)didFinishedRequest:(DVIHttpRequest *)request withData:(id)data;
- (void)didRequest:(DVIHttpRequest *)request withError:(id)error;
- (void)didCancelRequest:(DVIHttpRequest *)request;
@end

@interface DVIHttpRequest : NSObject
@property (nonatomic, assign) id<DVIHttpRequestDelegate> delegate;

@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *api;
@property (nonatomic, copy) NSString *method;

- (id)initWithDelegate:(id<DVIHttpRequestDelegate>)aDelegate;

- (void)setHttpBody:(NSData *)data;

- (void)cancel;

- (void)get:(NSString *)path parameter:(NSDictionary *)dict;
- (void)post:(NSString *)path parameter:(NSDictionary *)dict;
- (void)put:(NSString *)path data:(NSData *)data parameter:(NSDictionary *)dict;
- (void)put:(NSString *)path file:(NSString *)file parameter:(NSDictionary *)dict;
- (void)post:(NSString *)path data:(NSData *)data parameter:(NSDictionary *)dict;
@end
