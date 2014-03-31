//
//  DVIImageViewController.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIImageViewController.h"

#import "UIImageView+WebCache.h"

@interface DVIImageViewController () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_imageView;
}
@end

@implementation DVIImageViewController

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
    // Do any additional setup after loading the view.
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.maximumZoomScale = 10;  //缩放倍数
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _imageView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
    [_scrollView addSubview:_imageView];

    [_imageView setImageWithURL:[NSURL URLWithString: self.path]];   //封装SDWebImage

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView   //指定放大的view
{
    return _imageView;
}
@end
