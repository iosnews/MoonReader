//
//  config.h
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#ifndef WeiPanTest_config_h
#define WeiPanTest_config_h

#define kAccessTokenInfoKey @"kAccessTokenInfoKey"

#define kAppKey         @"3623860515"
#define kAppSecret      @"2ed304f665e20c8bcf8b4a17aae0f460"

//回调地址
#define kRedirectURL    @"http://www.diveinedu.cn/coderoom.php"

//获取登录授权
#define kWeipanAuthorizeURL     @"https://auth.sina.com.cn/oauth2/authorize"
//获取access_token
#define kWeipanAccessTokenURL   @"https://auth.sina.com.cn/oauth2/access_token"

//获取用户信息
#define kWeipanUserInfoURL      @"https://api.weipan.cn/2/account/info"

//获取文件或目录的信息
#ifdef DEBUG
    #define kWeipanMetadataURL  @"https://api.weipan.cn/2/metadata/sandbox"
#else
    #define kWeipanMetadataURL  @"https://api.weipan.cn/2/metadata/basic"
#endif

#ifdef DEBUG
    #define kWeipanRoot @"sandbox"
#else
    #define kWeipanRoot @"basic"
#endif

//下载文件
#define kWeipanFileURL          @"https://api.weipan.cn/2/files"
//下载缩略图
#define kWeipanThumbURL         @"https://api.weipan.cn/2/thumbnails"

//PUT方法上传文件
#define kWeipanPutFileURL       @"https://upload-vdisk.sina.com.cn/2/files_put"
//POST方法上传文件
#define kWeipanPostFileURL      @"https://upload-vdisk.sina.com.cn/2/files"

//登录后的通知
#define kLoginNotification          @"loginNotif"
//获取用户信息后的通知
#define kFetchUserInfoNotification  @"fetchUserInfo"
//获取目录或文件的信息后的通知
#define kFetchMetadataNotification  @"metadataNotif"

//下载完文件
#define kDownloadFileNotification   @"downloadNotif"

#define kUserInfoKey  @"userInfo"
#define kMetadataKey  @"metadata"
#define kFileNameKey  @"fileName"
#define kFileTypeKey  @"fileType"

#endif
