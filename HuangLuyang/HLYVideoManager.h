//
//  HLYVideoManager.h
//  HuangLuyang
//
//  Created by huangluyang on 14-7-18.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPRequestOperationManager.h>

@interface HLYVideoManager : AFHTTPRequestOperationManager

+ (instancetype)sharedInstance;

/**
 *  生成视频播放器js代码
 *
 *  @param vid 视频id
 *
 *  @return 播放器js代码
 */
- (NSString *)playerHTMLWithVideoId:(NSString *)vid;

- (void)fetchVideoListSuccess:(void (^)(NSArray *videos))success
                      failure:(void (^)(NSError *error))failure;

@end
