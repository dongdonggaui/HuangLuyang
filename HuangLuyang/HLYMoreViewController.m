//
//  HLYMoreViewController.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-22.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYMoreViewController.h"
#import "HLYActivityView.h"

@interface HLYMoreViewController () <UITableViewDelegate, UITableViewDataSource, HLYActivityDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation HLYMoreViewController

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

    self.title = NSLocalizedString(@"main_more", nil);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self deselectedTableViewAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark -
#pragma mark - private
- (void)deselectedTableViewAnimated:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
}


#pragma mark -
#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0 == section ? 2 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"moreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = NSLocalizedString(@"more_setting", nil);
        } else {
            cell.textLabel.text = NSLocalizedString(@"more_help", nil);
        }
    } else {
        if (indexPath.row == 0) {
            cell.textLabel.text = NSLocalizedString(@"more_rate", nil);
        } else if (indexPath.row == 1) {
            cell.textLabel.text = NSLocalizedString(@"more_share", nil);
        } else {
            cell.textLabel.text = NSLocalizedString(@"more_about", nil);
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            HLYActivityView *activity = [[HLYActivityView alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"btn_cancel", nil) ShareButtonTitles:@[NSLocalizedString(@"act_mail", nil), NSLocalizedString(@"act_wechat", nil)] withShareButtonImagesName:@[@"sns_icon_18", @"sns_icon_22"]];
            [activity showInView:self.view];
        } else if (indexPath.row == 2) {
            [self performSegueWithIdentifier:@"showAbout" sender:nil];
        }
    }
}

#pragma mark -
#pragma mark - activity delegate
- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    [self deselectedTableViewAnimated:YES];
}

- (void)didClickOnCancelButton
{
    [self deselectedTableViewAnimated:YES];
}

@end
