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

@property (nonatomic, strong) UIView      *contentView;
@property (nonatomic, strong) UIImageView *actor;
@property (nonatomic, strong) UIView      *bottomLayer;
@property (nonatomic, strong) UIView      *middleLayer;
@property (nonatomic, strong) UIView      *topLayer;

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
        
        _bottomLayer = [[UIView alloc] initWithFrame:self.bounds];
        self.bottomLayer.backgroundColor = [UIColor clearColor];
        self.bottomLayer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:self.bottomLayer];
        
        _middleLayer = [[UIView alloc] initWithFrame:self.bounds];
        self.middleLayer.backgroundColor = [UIColor clearColor];
        self.middleLayer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:self.bottomLayer];
        
        _actor = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.actor.center = self.contentView.center;
        UIImage *image = [UIImage imageWithColor:[UIColor greenColor]];
        self.actor.image = image;
        [self.contentView addSubview:self.actor];
        self.originalY = self.actor.y;
        
        _topLayer = [[UIView alloc] initWithFrame:self.bounds];
        self.topLayer.backgroundColor = [UIColor clearColor];
        self.topLayer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:self.topLayer];
    }
    return self;
}

#pragma mark -
#pragma mark - setters & getters
- (void)setState:(HLYStoryViewState)state
{
    switch (state) {
        case HLYStoryViewStateLeading:
            self.actor.y = 0;
            break;
            
        case HLYStoryViewStateRearing:
            self.actor.y = self.contentView.height - self.actor.height;
            break;
            
        default:
            self.actor.center = self.contentView.center;
            break;
    }
    _state = state;
}

#pragma mark -
#pragma mark - public
- (void)didScrollWithOffset:(CGFloat)offset
{
    self.actor.y = self.originalY + offset;
}

@end
