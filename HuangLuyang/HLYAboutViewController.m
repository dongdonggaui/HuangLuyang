//
//  HLYAboutViewController.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-22.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYAboutViewController.h"

@interface HLYAboutViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@end

@implementation HLYAboutViewController

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

    self.title = NSLocalizedString(@"more_about", nil);
    
    self.scrollView.alwaysBounceVertical = YES;
    
    NSDictionary *appDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [appDic objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"%@ : %@", NSLocalizedString(@"current_version", nil), appVersion];
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

@end
