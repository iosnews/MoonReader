//
//  DVIHeadTableViewCell.m
//  月光微盘
//
//  Created by 吴琼 on 14-3-31.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIHeadTableViewCell.h"

@implementation DVIHeadTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 4)];
        [self.contentView addSubview:_lineImageView];
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 8, 60, 60)];
        [self.contentView addSubview:_headImageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame), CGRectGetMinY(_headImageView.frame), 160, 60)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:24];
        _nameLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_nameLabel];
        
//        _wifiSwitch = [[ToggleView alloc] initWithFrame:CGRectMake(CGRectGetMidX(_headImageView.frame), CGRectGetMaxY(_headImageView.frame), 60, 20) toggleViewType:ToggleViewTypeNoLabel toggleBaseType:ToggleBaseTypeDefault toggleButtonType:ToggleButtonTypeDefault];
//        [self.contentView addSubview:_wifiSwitch];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame), CGRectGetMaxY(_nameLabel.frame), 160, 20)];
        _addressLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_addressLabel];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    
//}

@end
