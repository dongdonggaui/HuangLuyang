//
//  HLYStoryContentView.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYStoryContentView.h"
#import "UIView+Frame.h"
#import <UIImage+ImageWithColor.h>

@interface HLYStoryContentView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *descriptionView;

@property (nonatomic, strong) UIImageView *progeress;
@property (nonatomic, strong) UIImageView *cursor;

// move
@property (nonatomic, unsafe_unretained) CGFloat originalY;

@end

@implementation HLYStoryContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.contentView];
        
        self.progeress = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];
        self.progeress.image = [UIImage imageWithColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.progeress];
        
        self.cursor = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.cursor.image = [UIImage imageWithColor:[UIColor redColor]];
        [self.progeress addSubview:self.cursor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.progeress.y = self.contentView.height - self.progeress.height;
}

#pragma mark -
#pragma mark - setters & getters
- (void)setState:(HLYStoryViewState)state animated:(BOOL)animated
{
    [NSException raise:NSInternalInconsistencyException format:@"子类的 %s 方法必须重写", __FUNCTION__];
}

#pragma mark -
#pragma mark - public
- (void)didScrollWithOffset:(CGFloat)offset
{

}

- (void)handleScroll:(UIScrollView *)scrollView
{
    int offset = (int)scrollView.contentOffset.x % (int)scrollView.width;
    int halfWidth = (int)(scrollView.width / 2);
    self.cursor.x = halfWidth + (offset );
}

@end
