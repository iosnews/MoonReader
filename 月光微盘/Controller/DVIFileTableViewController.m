//
//  DVIFileTableViewController.m
//  WeiPanTest
//
//  Created by 吴琼 on 14-3-28.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIFileTableViewController.h"

#import "DVIFile.h"
#import "DVINetworkManager.h"

#import "DVIToken.h"

#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

#import "DVIImageViewController.h"
#import "ReaderViewController.h"

@interface DVIFileTableViewController () <ReaderViewControllerDelegate>
{
    DVIFile *_file;
}
@end

@implementation DVIFileTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData:) name:kFetchMetadataNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDownload:) name:kDownloadFileNotification object:nil];
    
    [[DVINetworkManager sharedManager] fetchMetadata:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData:(NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    _file = [dict objectForKey:kMetadataKey];
    
    self.title = _file.path;
    [self.tableView reloadData];
}

- (void)didDownload:(NSNotification *)notification
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSDictionary *dict = [notification userInfo];
    NSString *fileName = [dict objectForKey:kFileNameKey];
    NSString *fileType = [[dict objectForKey:kFileTypeKey] lowercaseString];
    
    if ([fileType isEqualToString:@"pdf"]) {
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:fileName password: nil];
        
        if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
        {
            ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            readerViewController.delegate = self; // Set the ReaderViewController delegate to self
            [self.navigationController pushViewController:readerViewController animated:YES];
        }

    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_file.contents) {
        return [_file.contents count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    DVIFile *file = [_file.contents objectAtIndex:indexPath.row];
    cell.textLabel.text = file.path;
    
    DVIToken *token = [DVIToken localToken];
    NSString *path = [NSString stringWithFormat:@"%@/%@%@?access_token=%@", kWeipanThumbURL, kWeipanRoot, file.path, token.access_token];  //缩略图的地址
    [cell.imageView setImageWithURL:[NSURL URLWithString:path]];  //通过框架里实现的方法下载
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DVIImageViewController *imageViewCtrl = [[DVIImageViewController alloc] init];
    
    DVIFile *file = [_file.contents objectAtIndex:indexPath.row];
    DVIToken *token = [DVIToken localToken];
    NSString *path = [NSString stringWithFormat:@"%@/%@%@?access_token=%@",kWeipanFileURL, kWeipanRoot, file.path, token.access_token];
                      
    if ([file.mime_type hasPrefix:@"image"]) {
        imageViewCtrl.path = path;
        [self.navigationController pushViewController:imageViewCtrl animated:YES];
    }
    else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [[DVINetworkManager sharedManager] downloadFile:file.path];
    }
}

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
