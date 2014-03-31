//
//  DVINetworkManager.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVINetworkManager.h"
#import "DVIDataManager.h"
#import "DVIClassManager.h"

#import "DVIToken.h"
#import "DVIUser.h"
#import "DVIFile.h"

#import "DVIHttpRequest.h"
#import "DVIDataHandler.h"

@interface DVINetworkManager ()  <DVIHttpRequestDelegate>
{
    NSMutableArray *_requestArray;
}
@end

@implementation DVINetworkManager

//创建一个单例类
+ (instancetype)sharedManager
{
    static DVINetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DVINetworkManager alloc] init];
    });
    
    return manager;
}

- (id)init
{
    if (self = [super init]) {
        _requestArray = [NSMutableArray array];
    }
    
    return self;
}

//获取用户信息
- (void)fetchUserInfo
{
    DVIToken *token = [DVIToken localToken];
    
    DVIHttpRequest *httpRequest = [[DVIHttpRequest alloc] initWithDelegate:self];
    [_requestArray addObject:httpRequest];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:token.access_token forKey:@"access_token"];
    [httpRequest post:kWeipanUserInfoURL parameter:dict];
}


//获取Metadta
- (void)fetchMetadata:(NSString *)path
{
    NSString *str = nil;
    if (path == nil || [path length] == 0) {
        str = [NSString stringWithFormat:@"%@", kWeipanMetadataURL];
    }
    else {
        str = [NSString stringWithFormat:@"%@/%@", kWeipanMetadataURL, path];
    }
    
    DVIToken *token = [DVIToken localToken];
    
    DVIHttpRequest *httpRequest = [[DVIHttpRequest alloc] initWithDelegate:self];
    [_requestArray addObject:httpRequest];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:token.access_token forKey:@"access_token"];

    httpRequest.api = kWeipanMetadataURL;
    [httpRequest get:str parameter:dict];
}

- (void)downloadFile:(NSString *)path
{
    DVIToken *token = [DVIToken localToken];
    
    DVIHttpRequest *httpRequest = [[DVIHttpRequest alloc] initWithDelegate:self];
    [_requestArray addObject:httpRequest];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token.access_token, @"access_token", nil];
    
    NSString *remotePath = [NSString stringWithFormat:@"%@/%@%@", kWeipanFileURL, kWeipanRoot, path];
    httpRequest.path = path;
    httpRequest.api = kWeipanFileURL;
    [httpRequest get:remotePath parameter:dict];
}

//上传本地数据
- (void)putFile:(NSString *)localPath toPath:(NSString *)remotePath
{
    DVIToken *token = [DVIToken localToken];
    
    DVIHttpRequest *httpRequest = [[DVIHttpRequest alloc] initWithDelegate:self];
    [_requestArray addObject:httpRequest];
    
//    NSData *data = [NSData dataWithContentsOfFile:localPath];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token.access_token, @"access_token", nil];
//    [httpRequest put: data:data parameter:dict];

    httpRequest.path = remotePath;
    httpRequest.api = kWeipanPutFileURL;
    remotePath = [NSString stringWithFormat:@"%@/%@%@", kWeipanPutFileURL, kWeipanRoot, remotePath];
    [httpRequest put:remotePath file:localPath parameter:dict];
}

- (void)postFile:(NSString *)localPath toPath:(NSString *)remotePath
{
    DVIToken *token = [DVIToken localToken];
    
    DVIHttpRequest *httpRequest = [[DVIHttpRequest alloc] initWithDelegate:self];
    [_requestArray addObject:httpRequest];
    
    NSData *data = [NSData dataWithContentsOfFile:localPath];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token.access_token, @"access_token", nil];
//    [httpRequest put: data:data parameter:dict];
    
    httpRequest.path = remotePath;
    httpRequest.api = kWeipanPostFileURL;
    remotePath = [NSString stringWithFormat:@"%@/%@%@", kWeipanPostFileURL, kWeipanRoot, remotePath];
    [httpRequest post:remotePath data: data parameter:dict];
}



- (void)didFinishedRequest:(DVIHttpRequest *)request withData:(id)data
{
    //取与请求对应的类名
    NSString *className = [[DVIClassManager sharedManager] classNameForKey:request.api];
    //从类名获取类
    Class cls = NSClassFromString(className);
    
    
    DVIDataHandler *dataHandler = [[cls alloc] init];
    dataHandler.path = request.path;
    
    //处理数据
    [dataHandler handlerData:data];
    
    [_requestArray removeObject:request];
}

- (void)didRequest:(DVIHttpRequest *)request withError:(id)error
{
    [_requestArray removeObject:request];
}

- (void)didCancelRequest:(DVIHttpRequest *)request
{
    [_requestArray removeObject:request];
}
@end
