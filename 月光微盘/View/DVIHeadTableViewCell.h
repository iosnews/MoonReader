//
//  DVIHeadTableViewCell.h
//  月光微盘
//
//  Created by 吴琼 on 14-3-31.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ToggleView.h"

@interface DVIHeadTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) ToggleView *wifiSwitch;

@end
