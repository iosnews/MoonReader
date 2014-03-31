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

#import <MessageUI/MessageUI.h>

#import "MBProgressHUD.h"
#import "UMSocial.h"

@interface DVIResourceTableViewController () <UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate>
{
    NSArray *_fileArray;
    DVIFile *_shareFile;
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

- (void)didShareClicked:(UIButton *)sender
{
    NSLog(@"%d", sender.tag);
    
    _shareFile = [_fileArray objectAtIndex:sender.tag];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"邮件分享", @"短信分享", @"社交分享", nil];
    [actionSheet showInView:self.view];
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
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"btn_share.png"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 32, 32);
        [button addTarget:self action:@selector(didShareClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
    }
    
    cell.accessoryView.tag = indexPath.row;
    
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

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mailCtrl = [[MFMailComposeViewController alloc] init];
            mailCtrl.mailComposeDelegate = self;
            [mailCtrl setSubject: [_shareFile.path lastPathComponent]];
            [mailCtrl setToRecipients:@[@"834675578@qq.com"]];
            [mailCtrl setCcRecipients:@[@"jjd1198@sina.com"]];
            [mailCtrl setBccRecipients:@[@"498158850@qq.com"]];
            [mailCtrl setMessageBody:@"<h1>这是一个标题</h1><center>居中的文字</center><img src=\"http://img.hb.aicdn.com/23433136bf53b10eea4e3b4aed6896e066b4510c16412-f8lJwk_fw658\">" isHTML:YES];
            
            NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", _shareFile.path];
            NSData *data = [NSData dataWithContentsOfFile:path];
            [mailCtrl addAttachmentData:data mimeType:@"image/jpg" fileName:[_shareFile.path lastPathComponent ]];
            [self presentViewController:mailCtrl animated:YES completion:nil];
        }
        else {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"还没有设置邮箱";
            hud.removeFromSuperViewOnHide = YES;
            [hud show:YES];
            [hud hide:YES afterDelay:0.8];
        }
    }
    else if (buttonIndex == 1) {
        if ([MFMessageComposeViewController canSendText]) {
            MFMessageComposeViewController *messageCtrl = [[MFMessageComposeViewController alloc] init];
            [messageCtrl setBody:@"Test message"];
            messageCtrl.messageComposeDelegate = self;
            [self presentViewController:messageCtrl animated:YES completion:nil];
        }
    }
    else {
        NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", _shareFile.path];
        
        //533950f656240b023500f01d
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"533950f656240b023500f01d"
                                          shareText:@"你要分享的文字"
                                         shareImage:[UIImage imageWithContentsOfFile:path]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession, UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                           delegate:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:^{
        NSString *message = nil;
        switch (result) {
            case MFMailComposeResultSaved:
                message = @"邮件被保存";
                break;
            case MFMailComposeResultSent:
                message = @"邮件发送成功";
                break;
            default:
                message = @"没发出去";
                break;
        }
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        hud.removeFromSuperViewOnHide = YES;
        [hud show:YES];
        [hud hide:YES afterDelay:0.8];
    }];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSLog(@"....message");
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    //iMessage
}
@end
