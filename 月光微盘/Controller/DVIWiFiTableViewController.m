//
//  DVIWiFiTableViewController.m
//  月光微盘
//
//  Created by 吴琼 on 14-3-31.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIWiFiTableViewController.h"

#import "HTTPServer.h"
#import "MyHTTPConnection.h"

#include <ifaddrs.h>
#include <arpa/inet.h>

@interface DVIWiFiTableViewController ()
{
    UIImageView *_wifiImageView;
    UILabel *_addressLabel;
    
    HTTPServer *_server;
}
@end

@implementation DVIWiFiTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 94)];
    self.tableView.tableHeaderView = headerView;
    
    _wifiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 55, 55)];
    _wifiImageView.image = [UIImage imageNamed:@"wifi_server_icon_s.png"];
    [headerView addSubview:_wifiImageView];
    
    UIButton *wifiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [wifiButton setImage:[UIImage imageNamed:@"wifi_off.png"] forState:UIControlStateNormal];
    [wifiButton setImage:[UIImage imageNamed:@"wifi_on.png"] forState:UIControlStateSelected];
    [wifiButton addTarget:self action:@selector(didWifiClicked:) forControlEvents:UIControlEventTouchUpInside];
    wifiButton.frame = CGRectMake(10, CGRectGetMaxY(_wifiImageView.frame), 80, 34);
    [headerView addSubview:wifiButton];
    
    _wifiImageView.center = CGPointMake(CGRectGetMidX(wifiButton.frame), _wifiImageView.center.y);
    
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_wifiImageView.frame) + 10, CGRectGetMinY(_wifiImageView.frame), 300, 30)];
    _addressLabel.center = CGPointMake(_addressLabel.center.x, _wifiImageView.center.y);
    _addressLabel.textColor = [UIColor colorWithRed:91.0/255 green:169.0/255 blue:61.0/255 alpha:1];
    _addressLabel.font = [UIFont systemFontOfSize:26];
//    _addressLabel.text = @"192.168.1.33:12345";
    [headerView addSubview:_addressLabel];
}

- (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

- (void)didWifiClicked:(UIButton *)sender
{
    if (sender.selected) {
        [_server stop];
    }
    else {
        _server = [[HTTPServer alloc] init];
        [_server setType:@"_http._tcp."];
        [_server setPort:12345];
        [_server setConnectionClass:[MyHTTPConnection class]];
        
        NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
        [_server setDocumentRoot:webPath];
        NSError *error = nil;
        if(![_server start:&error])
        {
            return;
        }
        
        NSLog(@"address: %@", [self getIPAddress]);
        NSLog(@"%d", [_server port]);
        
        _addressLabel.text = [NSString stringWithFormat:@"%@:%d", [self getIPAddress], [_server port]];
    }
    
    sender.selected = !sender.selected;
    _wifiImageView.image = sender.selected?[UIImage imageNamed:@"wifi_server_icon.png"]:[UIImage imageNamed:@"wifi_server_icon_s.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wifiCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"历史记录";
}

@end
