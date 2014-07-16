//
//  HLYStoryView.h
//  HuangLuyang
//
//  Created by huangluyang on 14-7-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLYStoryView : UIView

@property (nonatomic, strong, readonly) UIScrollView   *scrollView;
@property (nonatomic, strong, readonly) NSMutableArray *contentViews;

- (instancetype)initWithFrame:(CGRect)frame contentViews:(NSArray *)contentViews;

@end
