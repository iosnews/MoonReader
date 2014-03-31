//
//  DVIMasterViewController.m
//  月光微盘
//
//  Created by 吴琼 on 14-3-31.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIMasterViewController.h"

#import "DVIDetailViewController.h"

#import "DVIHeadTableViewCell.h"
#import "DVICategoryTableViewCell.h"

#import "ToggleView.h"

@interface DVIMasterViewController () <ToggleViewDelegate>
{
    NSArray *_localCellArray;
    NSArray *_remoteCellArray;
}
@end

@implementation DVIMasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _localCellArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"localCell" ofType:@"plist"]];
    _remoteCellArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"remoteCell" ofType:@"plist"]];

    self.detailViewController = (DVIDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [self.tableView registerClass:[DVIHeadTableViewCell class] forCellReuseIdentifier:@"headCell"];
    [self.tableView registerClass:[DVICategoryTableViewCell class] forCellReuseIdentifier:@"categoryCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    UIView *toolbar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44)];
    toolbar.backgroundColor = [UIColor redColor];
    [self.view addSubview:toolbar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 5;
        case 2:
            return 4;
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DVIHeadTableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell" forIndexPath:indexPath];
        
        headCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *bgImageView = (UIImageView *)headCell.backgroundView;   
        [headCell.contentView addSubview:bgImageView];
        bgImageView.image = [UIImage imageNamed:@"menu_cell_bg.png"];
        headCell.lineImageView.image = [UIImage imageNamed:@"menu_line.png"];
        headCell.headImageView.image = [UIImage imageNamed:@"default_profile.png"];
        headCell.nameLabel.text = @"杨总的阅读器";
        headCell.addressLabel.text = @"192.168.1.fuck";
        headCell.wifiSwitch.toggleDelegate = self;
        
        return headCell;
    }
    else if (indexPath.section == 1) {
        DVICategoryTableViewCell *localCell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
        NSDictionary *dict = [_localCellArray objectAtIndex:indexPath.row];
        
        localCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *bgImageView = (UIImageView *)localCell.backgroundView;
        bgImageView.image = [UIImage imageNamed:@"menu_cell_bg.png"];
        localCell.lineImageView.image = [UIImage imageNamed:@"menu_line.png"];
        localCell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        localCell.textLabel.text = [dict objectForKey:@"title"];
        
        return localCell;
    }
    else {
        DVICategoryTableViewCell *remoteCell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
        NSDictionary *dict = [_remoteCellArray objectAtIndex:indexPath.row];
        
        remoteCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *bgImageView = (UIImageView *)remoteCell.backgroundView;
        bgImageView.image = [UIImage imageNamed:@"menu_cell_bg.png"];
        remoteCell.lineImageView.image = [UIImage imageNamed:@"menu_line.png"];
        remoteCell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        remoteCell.textLabel.text = [dict objectForKey:@"title"];
        
        return remoteCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }
    
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return nil;
        case 1:
            return @"我的文件";
        case 2:
            return @"文件来源";
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadData];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *bgImageView = (UIImageView *)cell.backgroundView;
    bgImageView.image = [UIImage imageNamed:@"menu_cell_bg_s.png"];
}

#pragma mark - ToggleViewDelegate
- (void)selectLeftButton
{
    NSLog(@"left button");
}

- (void)selectRightButton
{
    NSLog(@"right button");
}
@end
