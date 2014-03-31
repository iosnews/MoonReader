//
//  DVILoginViewController.h
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DVILoginViewControllerDelegate <NSObject>

@optional
- (void)didLoginWithToken:(NSString *)token;
- (void)didCancelLogin;

@end

@interface DVILoginViewController : UIViewController

@property (nonatomic, assign) id<DVILoginViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *path;

- (void)loginWithURL:(NSString *)url;
@end
