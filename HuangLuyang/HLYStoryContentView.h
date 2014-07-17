//
//  HLYStoryContentView.h
//  HuangLuyang
//
//  Created by huangluyang on 14-7-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HLYStoryViewStateInitial,
    HLYStoryViewStateTerminal,
} HLYStoryViewState;

@interface HLYStoryContentView : UIView

@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UIView *descriptionView;

@property (nonatomic, strong, readonly) UIImageView *progeress;
@property (nonatomic, strong, readonly) UIImageView *cursor;

@property (nonatomic, unsafe_unretained) HLYStoryViewState state;

- (void)didScrollWithOffset:(CGFloat)offset;
- (void)handleScroll:(UIScrollView *)scrollView;

- (void)setState:(HLYStoryViewState)state animated:(BOOL)animated;

@end
