//
//  HLYStoryContentView.h
//  HuangLuyang
//
//  Created by huangluyang on 14-7-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HLYStoryViewStateLeading,
    HLYStoryViewStateMiddle,
    HLYStoryViewStateRearing,
} HLYStoryViewState;

@interface HLYStoryContentView : UIView

@property (nonatomic, strong, readonly) UIImageView *actor;
@property (nonatomic, strong, readonly) UIView      *bottomLayer;
@property (nonatomic, strong, readonly) UIView      *meddleLayer;
@property (nonatomic, strong, readonly) UIView      *topLayer;

@property (nonatomic, unsafe_unretained) HLYStoryViewState state;

- (void)didScrollWithOffset:(CGFloat)offset;

@end
