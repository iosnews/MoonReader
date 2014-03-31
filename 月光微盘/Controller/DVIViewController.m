//
//  DVIViewController.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIViewController.h"

#import "DVIRequestClient.h"
#import "DVINetworkManager.h"

#import "DVIUser.h"

#import "UIImageView+WebCache.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

#import "MyHTTPConnection.h"

@interface DVIViewController ()
{
    DVIRequestClient *_client;
    HTTPServer *_server;
}
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation DVIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogin:) name:kLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFetchUserInfo:) name:kFetchUserInfoNotification object:nil];
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"docx"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didLoginClicked:(id)sender {
    if (![DVIRequestClient isLogin])  //判断是否为第一次登录
    {
        _client = [[DVIRequestClient alloc] init];
        [_client loginFromController:self];         //创建并弹出登录页面
    }
    else {
        [[DVINetworkManager sharedManager] fetchUserInfo]; //获取用户信息
    }
}

- (IBAction)didMetadataClicked:(id)sender {
    
}

- (IBAction)didSendClicked:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"markdown" ofType:@"pdf"];
//    [[DVINetworkManager sharedManager] putFile:path toPath:@"/test2.jpg"];
    [[DVINetworkManager sharedManager] postFile:path toPath:@"/markdown.pdf"];
}

- (void)didLogin:(NSNotification *)notification
{
    [[DVINetworkManager sharedManager] fetchUserInfo];  //获取用户信息
}

- (IBAction)didHttpServerClicked:(id)sender {
    _server = [[HTTPServer alloc] init];
    [_server setType:@"_http._tcp."];
    [_server setPort:12345];
    [_server setConnectionClass:[MyHTTPConnection class]];
    
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    [_server setDocumentRoot:webPath];
    NSError *error = nil;
	if(![_server start:&error])
	{
		DDLogError(@"Error starting HTTP Server: %@", error);
	}
    
    NSLog(@"address: %@", [_server interface]);
    NSLog(@"%d", [_server port]);
}

//显示用户信息
- (void)didFetchUserInfo:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    DVIUser *user = [userInfo objectForKey:kUserInfoKey];
    [_avatarImageView setImageWithURL:[NSURL URLWithString:user.avatar_large]];
    _userNameLabel.text = user.user_name;
    _locationLabel.text = user.location;
}


//在对象销毁时将其从消息中心中移除
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
