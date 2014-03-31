//
//  DVIHttpRequest.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIHttpRequest.h"
#import "DVIUser.h"

#import "NSDictionary+Utils.h"

@interface DVIHttpRequest () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSMutableData *_responseData;
    
    NSMutableURLRequest *_request;
    NSURLConnection *_connection;
    
    unsigned long long _fileSize;
}
@end

@implementation DVIHttpRequest

- (id)initWithDelegate:(id<DVIHttpRequestDelegate>)aDelegate    //
{
    if (self = [super init]) {
        self.delegate = aDelegate;
    }
    
    return self;
}

- (void)setHttpBody:(NSData *)data
{
    [_request setHTTPBody:data];
}

- (void)setMethod:(NSString *)method
{
    [_request setHTTPMethod:method];
    _method = method;
}

- (void)start
{    
    _connection = [[NSURLConnection alloc] initWithRequest:_request delegate: self];
    [_connection start];
}

- (void)cancel
{
    [_connection cancel];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didCancelRequest:)]) {
        [_delegate didCancelRequest:self];
    }
}

- (void)get:(NSString *)path parameter:(NSDictionary *)dict
{    
    NSString *param = [dict URLString];
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@", path, param];
    
    NSURL *url = [NSURL URLWithString: urlStr];
    _request = [NSMutableURLRequest requestWithURL:url];
    
    [self start];
}

- (void)post:(NSString *)path parameter:(NSDictionary *)dict
{
    self.api = path;
    
    NSString *param = [dict URLString];
    
    NSURL *url = [NSURL URLWithString: path];
    _request = [NSMutableURLRequest requestWithURL:url];
    [self setHttpBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    [self setMethod:@"POST"];
    
    [self start];
}

- (void)put:(NSString *)path data:(NSData *)data parameter:(NSDictionary *)dict
{
    self.api = path;
    NSString *param = [dict URLString];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", path, param]];
    _request = [NSMutableURLRequest requestWithURL:url];
    [self setHttpBody: data];
    [self setMethod:@"PUT"];
    
    [self start];
}

- (void)put:(NSString *)path file:(NSString *)file parameter:(NSDictionary *)dict
{
    NSString *param = [dict URLString];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", path, param]];
    _request = [NSMutableURLRequest requestWithURL:url];
    
    NSDictionary *fileAttr = [[NSFileManager defaultManager] attributesOfItemAtPath:file error:nil];
    _fileSize = [fileAttr fileSize];
    
    NSInputStream *stream = [[NSInputStream alloc] initWithFileAtPath:file];
    [_request setHTTPBodyStream:stream];
    [self setMethod:@"PUT"];
    
    [self start];
}

- (void)post:(NSString *)path data:(NSData *)data parameter:(NSDictionary *)dict
{
    NSString *param = [dict URLString];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", path, param]];
    _request = [NSMutableURLRequest requestWithURL:url];
    
    //1. 设置header field的Content-Type为(multipart/form-data; boundary=ABC)
    //2. 设置body
    //3. 起始边界(--ABC)
    //4. 内容的位置与参数名字（Content-Disposition: form-data; name="参数名"; filename="test2.jpg"\r\n）
    //5. 内容的格式(Content-Type: image/jpg\r\n\r\n)...(application/octet-stream)
    //6. 结束边界(--ABC--)
    //7. 有多张图片(4-6)
    
    //1. 指定body里数据的边界
    [_request addValue:@"multipart/form-data; boundary=------------------------123" forHTTPHeaderField:@"Content-Type"];
    
    //注意： 真正的边界比上面定义的要多两个'-'
    NSString *boundary = [NSString stringWithFormat:@"\r\n--%@\r\n", @"------------------------123"];
    NSMutableData *bodyData = [NSMutableData data];
    
    //2. 添加第一个边界
    [bodyData appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
    
    //3. 添加文件位置说明
    NSString *dispositionStr = @"Content-Disposition: form-data; name=\"file\"; filename=\"markdown.pdf\"\r\n";
    [bodyData appendData: [dispositionStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    //4. 添加文件内容格式信息
    NSString *contentTypeStr = @"Content-Type: application/octet-stream\r\n\r\n";
    [bodyData appendData:[contentTypeStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    //5. 添加需要发生的数据
    [bodyData appendData:data];
    
    //6. 添加结束边界
    NSString *endBoundary = [NSString stringWithFormat:@"\r\n--%@--\r\n", @"------------------------123"];
    [bodyData appendData:[endBoundary dataUsingEncoding:NSUTF8StringEncoding]];
    
    //7. 如果有多个文件或者多种参数，重复3-6步
    
    [self setHttpBody:bodyData];
    [self setMethod:@"POST"];
    
    [self start];
}

//NSURLConnection开始响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ([httpResponse statusCode] == 200) {
        _responseData = [NSMutableData data];
    }
    else {
        //错误处理
        NSLog(@"状态码: %d", [httpResponse statusCode]);
        
        if (_delegate && [_delegate respondsToSelector:@selector(didRequest:withError:)]) {
            [_delegate didRequest:self withError:nil];
        }
    }
}

//收集下载的数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

//文件发送进度
- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    if (totalBytesExpectedToWrite <= 0) {
        NSLog(@"%.2f%%", totalBytesWritten * 100.0 / _fileSize);
    }
    else {
        NSLog(@" %.2f%%", totalBytesWritten * 100.0 / totalBytesExpectedToWrite);
    }
}

//下载完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_delegate && [_delegate respondsToSelector:@selector(didFinishedRequest:withData:)]) {
        [_delegate didFinishedRequest:self withData:_responseData];
    }
    
    NSLog(@"connection did finished...");
}

//下载失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [_delegate respondsToSelector:@selector(didRequest:withError:)]) {
        [_delegate didRequest:self withError:error];
    }
}
@end
