//
//  DVICategoryTableViewCell.m
//  月光微盘
//
//  Created by 吴琼 on 14-3-31.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVICategoryTableViewCell.h"

@implementation DVICategoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 4)];
        [self.contentView addSubview:_lineImageView];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(24, 4, 36, 36);
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 50, 4, 100, 36);
}

@end
