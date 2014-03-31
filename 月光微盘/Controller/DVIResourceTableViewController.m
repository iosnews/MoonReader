//
//  DVIResourceTableViewController.m
//  月光微盘
//
//  Created by 吴琼 on 14-3-31.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIResourceTableViewController.h"

#import "DVIResourceTableViewCell.h"

#import "DVIDataManager.h"
#import "DVIFile.h"

@interface DVIResourceTableViewController ()
{
    NSArray *_fileArray;
}
@end

@implementation DVIResourceTableViewController

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
    
    _fileArray = [[DVIDataManager sharedManager] currentFileArray];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [_fileArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"cellIdentifier";
    
    DVIResourceTableViewCell *cell = (DVIResourceTableViewCell *)[tableView dequeueReusableCellWithIdentifier: cellIdentifer];
    if (cell == nil) {
        cell = [[DVIResourceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifer];
    }
    
    DVIFile *file = [_fileArray objectAtIndex:indexPath.row];
    
    UIImage *image = [UIImage imageNamed: file.file_icon];
    if (!image) {
        image = [UIImage imageNamed:@"icon_unknow.png"];
    }
    
    cell.imageView.image = image;
    cell.textLabel.text = file.path;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fk %@", [file.size longLongValue] * 1.0 / 1024, file.modified];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


@end
