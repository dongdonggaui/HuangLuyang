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

@interface HLYStoryView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView    *actor;
@property (nonatomic, strong) UIScrollView   *scrollView;
@property (nonatomic, strong) NSMutableArray *contentViews;
@property (nonatomic, unsafe_unretained) NSInteger currentPageIndex;
@property (nonatomic, unsafe_unretained) NSInteger lastPosition;

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
        self.contentViews = [NSMutableArray arrayWithArray:contentViews];
        NSInteger count = self.contentViews.count;
        
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame) * count);
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
        
        for (int i = 0; i < count; i++) {
            HLYStoryContentView *contentView = [contentViews objectAtIndex:i];
            contentView.y = i * self.scrollView.height;
            [self.scrollView addSubview:contentView];
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

#pragma mark -
#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPostion = scrollView.contentOffset.y;
    NSInteger offset = currentPostion - self.lastPosition;
    HLYStoryContentView *currentView = [self.contentViews objectAtIndex:self.currentPageIndex];
    NSAssert([currentView isKindOfClass:[HLYStoryContentView class]], @"contentView 必须是 HLYStoryContentView");
    [currentView didScrollWithOffset:offset];
    
    HLYStoryContentView *nextView = nil;
    CGFloat nextOffset = 0;
    if (offset > 5 && self.currentPageIndex < self.contentViews.count - 1) {
        nextView = [self.contentViews objectAtIndex:self.currentPageIndex + 1];
        nextOffset = offset - scrollView.height;
    }
    else if (offset < -5 && self.currentPageIndex > 0)
    {
        nextView = [self.contentViews objectAtIndex:self.currentPageIndex - 1];
        nextOffset = offset + scrollView.height;
    }
    
    if (nextView) {
        [nextView didScrollWithOffset:nextOffset];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    [scrollView setContentOffset:CGPointMake(0, scrollView.frame.size.height) animated:YES];
    self.currentPageIndex = (int)scrollView.contentOffset.y / (int)scrollView.height;
    self.lastPosition = (int)scrollView.contentOffset.y;
}

@end
