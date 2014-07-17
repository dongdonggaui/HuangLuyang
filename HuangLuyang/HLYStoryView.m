//
//  HLYStoryView.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYStoryView.h"
#import "HLYStoryContentView.h"

#import "UIView+Frame.h"
#import <UIImage+ImageWithColor.h>

@interface HLYLayer : UIView

@end

@implementation HLYLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.clipsToBounds = YES;
        self.opaque = NO;
    }
    
    return self;
}

@end

@interface HLYStoryView () <UIScrollViewDelegate>

// layer
@property (nonatomic, strong) HLYLayer *backgourndLayer;
@property (nonatomic, strong) HLYLayer *bottomLayer;
@property (nonatomic, strong) HLYLayer *actorLayer;

//
@property (nonatomic, strong) UIImageView    *actor;
@property (nonatomic, strong) UIScrollView   *scrollView;
@property (nonatomic, strong) NSMutableArray *contentViews;
@property (nonatomic, unsafe_unretained) NSInteger currentPageIndex;

@end

@implementation HLYStoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame contentViews:(NSArray *)contentViews
{
    if (self = [self initWithFrame:frame]) {
        self.backgourndLayer = [[HLYLayer alloc] initWithFrame:self.bounds];
        [self addSubview:self.backgourndLayer];
        self.bottomLayer = [[HLYLayer alloc] initWithFrame:self.bounds];
        [self addSubview:self.bottomLayer];
        self.actorLayer = [[HLYLayer alloc] initWithFrame:self.bounds];
        self.actorLayer.userInteractionEnabled = NO;
        [self addSubview:self.actorLayer];
        
        self.actor = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.actor.center = self.actorLayer.center;
        self.actor.y = self.actorLayer.height - self.actor.height - 15;
        self.actor.image = [UIImage imageWithColor:[UIColor greenColor]];
        [self.actorLayer addSubview:self.actor];
        
        self.contentViews = [NSMutableArray arrayWithArray:contentViews];
        NSInteger count = self.contentViews.count;
        
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * count, CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        [self.bottomLayer addSubview:self.scrollView];
        self.currentPageIndex = 0;
        
        for (int i = 0; i < count; i++) {
            HLYStoryContentView *contentView = [contentViews objectAtIndex:i];
            contentView.x = i * self.scrollView.width;
            [self.scrollView addSubview:contentView];
        }
        
        //TODO: 素材待替换
        UIImageView *sky = [[UIImageView alloc] initWithFrame:self.backgourndLayer.bounds];
        sky.image = [UIImage imageWithColor:[UIColor blueColor]];
        sky.tag = 101;
        [self.backgourndLayer addSubview:sky];
        
        UIImageView *sun = [[UIImageView alloc] initWithFrame:CGRectMake(0, 160, 30, 30)];
        sun.image = [UIImage imageWithColor:[UIColor orangeColor]];
        sun.tag = 102;
        [self.backgourndLayer addSubview:sun];
        
        for (int i = 0; i < 3; i++) {
            UIImageView *cloud = [[UIImageView alloc] initWithFrame:CGRectMake(i * 60, i == 0 ? 70 : 10 + i * 30, 40, 27)];
            cloud.image = [UIImage imageWithColor:[UIColor lightGrayColor]];
            cloud.tag = 200 + i;
            [self.backgourndLayer addSubview:cloud];
        }
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark -
#pragma mark - private
- (void)moveBackground
{
    CGPoint offset = self.scrollView.contentOffset;
    UIImageView *sun = (UIImageView *)[self.backgourndLayer viewWithTag:102];
    sun.x = offset.x / self.contentViews.count;
    int halfWidth = self.scrollView.contentSize.width / 2;
    sun.y = (offset.x - halfWidth) * (offset.x - halfWidth) / (halfWidth * halfWidth / 100.) + 60;
    
    for (int i = 0; i < 3; i++) {
        UIImageView *cloud = (UIImageView *)[self.backgourndLayer viewWithTag:200 + i];
        cloud.x = offset.x / self.contentViews.count + i * 60;
    }
}

#pragma mark -
#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self moveBackground];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

@end
