//
//  DVIRequestClient.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIRequestClient.h"
#import "NSString+Utils.h"

#import "DVIToken.h"

#import "DVILoginViewController.h"

@interface DVIRequestClient () <DVILoginViewControllerDelegate>
{
    DVILoginViewController *_loginCtrl;
}
@end

@implementation DVIRequestClient

//创建并弹出登录的视图控制器
- (void)loginFromController:(UIViewController *)viewController
{
    NSString *encodedRedirectURL = [kRedirectURL URLEncodedString]; //进行URL编码
    NSString *url = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&display=mobile&response_type=code", kWeipanAuthorizeURL, kAppKey, encodedRedirectURL];
    
    _loginCtrl = [[DVILoginViewController alloc] initWithNibName: @"DVILoginViewController" bundle:nil];
    _loginCtrl.path = url;
    _loginCtrl.delegate = self;
    
    [viewController presentViewController:_loginCtrl animated:YES completion:NULL];
}

//获取access_token，和用户信息
- (void)fetchAccessToken:(NSString *)token
{
    NSString *encodedRedirectURL = [kRedirectURL URLEncodedString];
    NSString *params = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@", kAppKey, kAppSecret, token, encodedRedirectURL];
    NSLog(@"%@", params);
    
    NSURL *accessURL = [NSURL URLWithString:kWeipanAccessTokenURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:accessURL];
    [request setHTTPMethod: @"POST"];  //设置下载方式
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLResponse *response = NULL;
    NSError *error = NULL;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (!error && ([httpResponse statusCode] == 200)) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@\n%@\n%@", response, error, dict);
        
        DVIToken *token = [DVIToken token:dict];
        [token saveToken];
        
        [_loginCtrl dismissViewControllerAnimated:YES completion:NULL];
        _loginCtrl = nil;
        
        //通过通知，获取并显示用户信息
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNotification object: nil];
    }
}

//需要增加对超时时间的判断，超时后需要重新登陆
+ (BOOL)isLogin   //判断是否第一次登录，
{
    if ([DVIToken localToken]) {
        return YES;
    }
    
    return NO;
}

//1. 第一步认证完成的时间
- (void)didLoginWithToken:(NSString *)token
{
    [self fetchAccessToken:token];  //获取access_token，并通过access_token获取用户信息
}


//取消登录
- (void)didCancelLogin
{
    [_loginCtrl dismissViewControllerAnimated:YES completion:NULL];
    _loginCtrl = nil;
}
@end
