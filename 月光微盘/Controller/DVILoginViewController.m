//
//  DVILoginViewController.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVILoginViewController.h"

@interface DVILoginViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *loginWebView;
@end

@implementation DVILoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loginWithURL:_path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginWithURL:(NSString *)url
{
    NSURL *loginURL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:loginURL]; //创建一个请求
    [_loginWebView loadRequest:request];  //在WebView中显示登录页面
}


//当要请求数据时调用，会调用三次，第一次加载登录页面时调用，第二次点击登录后调用，第三次返回token时调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *path = [request.URL absoluteString];  //将URL转化成字符串
    if ([path hasPrefix:kRedirectURL])  //判断是否返回token
    {
        NSArray *array = [path componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#&"]];
        NSString *access_tokenStr = [array objectAtIndex: 0];
        NSArray *tokens = [access_tokenStr componentsSeparatedByString:@"="];
        NSString *token = [tokens lastObject];
        
        if (_delegate && [_delegate respondsToSelector:@selector(didLoginWithToken:)]) {
            [_delegate didLoginWithToken:token];//通过token获取access_token,并通过access_tonken获取并显示用户信息
        }
        
        return NO;
    }
    
    return YES;
}


//取消登录
- (IBAction)didCancelClicked:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didCancelLogin)]) {
        [_delegate didCancelLogin];
    }
}
@end
