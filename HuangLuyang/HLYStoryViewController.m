//
//  HLYStoryViewController.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYStoryViewController.h"
#import "HLYStoryView.h"
#import "HLYStoryContentView.h"

#import "UIView+Frame.h"

@interface HLYStoryViewController ()

@end

@implementation HLYStoryViewController

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
    
    self.view.backgroundColor = [UIColor blackColor];
    self.view.opaque = YES;
    CGRect frame = CGRectMake(0, (self.view.height - 352) / 2, self.view.width, 352);
    HLYStoryContentView *bornView = [[HLYStoryContentView alloc] initWithFrame:frame];
    bornView.backgroundColor = [UIColor clearColor];
    [bornView setState:HLYStoryViewStateInitial animated:YES];
    HLYStoryContentView *elementarySchoolView = [[HLYStoryContentView alloc] initWithFrame:frame];
    elementarySchoolView.backgroundColor = [UIColor clearColor];
    HLYStoryContentView *juniorMiddleSchoolView = [[HLYStoryContentView alloc] initWithFrame:frame];
    juniorMiddleSchoolView.backgroundColor = [UIColor clearColor];
    HLYStoryContentView *seniorMiddleSchoolView = [[HLYStoryContentView alloc] initWithFrame:frame];
    seniorMiddleSchoolView.backgroundColor = [UIColor clearColor];
    HLYStoryContentView *bachelorUniversityView = [[HLYStoryContentView alloc] initWithFrame:frame];
    bachelorUniversityView.backgroundColor = [UIColor clearColor];
    HLYStoryContentView *haierView = [[HLYStoryContentView alloc] initWithFrame:frame];
    haierView.backgroundColor = [UIColor clearColor];
    HLYStoryContentView *masterUniversityView = [[HLYStoryContentView alloc] initWithFrame:frame];
    masterUniversityView.backgroundColor = [UIColor clearColor];
    HLYStoryContentView *wanmeiView = [[HLYStoryContentView alloc] initWithFrame:frame];
    wanmeiView.backgroundColor = [UIColor clearColor];
    HLYStoryView *storyView = [[HLYStoryView alloc] initWithFrame:frame contentViews:@[bornView, elementarySchoolView, juniorMiddleSchoolView, seniorMiddleSchoolView, bachelorUniversityView, haierView, masterUniversityView, wanmeiView]];
    [self.view addSubview:storyView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
