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
    
    HLYStoryContentView *view1 = [[HLYStoryContentView alloc] initWithFrame:self.view.bounds];
    view1.backgroundColor = [UIColor yellowColor];
    HLYStoryContentView *view2 = [[HLYStoryContentView alloc] initWithFrame:self.view.bounds];
    view2.backgroundColor = [UIColor blueColor];
    HLYStoryContentView *view3 = [[HLYStoryContentView alloc] initWithFrame:self.view.bounds];
    view3.backgroundColor = [UIColor whiteColor];
    HLYStoryContentView *view4 = [[HLYStoryContentView alloc] initWithFrame:self.view.bounds];
    view4.backgroundColor = [UIColor orangeColor];
    HLYStoryView *storyView = [[HLYStoryView alloc] initWithFrame:self.view.bounds contentViews:@[view1, view2, view3, view4]];
    [self.view addSubview:storyView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
