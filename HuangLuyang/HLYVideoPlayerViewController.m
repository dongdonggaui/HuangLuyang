//
//  HLYVideoPlayerViewController.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-18.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYVideoPlayerViewController.h"
#import "HLYVideoManager.h"
#import "HLYVideo.h"

@interface HLYVideoPlayerViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HLYVideoPlayerViewController

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
    
    self.webView.delegate = self;
    
    NSString *vid = self.passValue && [self.passValue isKindOfClass:[HLYVideo class]] ? ((HLYVideo *)self.passValue).vid : @"XMzY1MDcwNTk2";
    NSString *html = [[HLYVideoManager sharedInstance] playerHTMLWithVideoId:vid];
    [self.webView loadHTMLString:html baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - web view delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
