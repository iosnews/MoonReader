//
//  DVIResourceTableViewCell.m
//  月光微盘
//
//  Created by 吴琼 on 14-3-31.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIResourceTableViewCell.h"

@implementation DVIResourceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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
    
    self.imageView.frame = CGRectMake(4, 4, 36, 36);
    
    CGRect rect = self.imageView.frame;
    CGFloat x = CGRectGetMaxX(rect);
    CGFloat y = CGRectGetMinY(rect);
    self.textLabel.frame = CGRectMake(x, y, self.bounds.size.width - 80, 20);
    
    CGRect textRect = self.textLabel.frame;
    self.detailTextLabel.frame = CGRectMake(x, CGRectGetMaxY(textRect), textRect.size.width, 20);
}
@end
