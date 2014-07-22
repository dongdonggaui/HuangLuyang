//
//  HLYActivityView.h
//  HuangLuyang
//
//  Created by huangluyang on 14-7-22.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLYActivityDelegate <NSObject>
- (void)didClickOnImageIndex:(NSInteger *)imageIndex;
@optional
- (void)didClickOnCancelButton;
@end

@interface HLYActivityView : UIView

- (id)initWithTitle:(NSString *)title delegate:(id<HLYActivityDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray;
- (void)showInView:(UIView *)view;

@end
