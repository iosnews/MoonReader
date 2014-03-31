//
//  DVIDetailViewController.h
//  月光微盘
//
//  Created by 吴琼 on 14-3-31.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVIDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
