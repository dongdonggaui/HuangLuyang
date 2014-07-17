//
//  NSString+Encrypt.h
//  WanmeiAD
//
//  Created by huangluyang on 14-7-4.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)

+ (NSString *)WM_generateAppkeyWithColumnId:(NSString *)columnId appId:(NSString *)appid;
- (NSString *)WM_md5Lowercase;
- (NSString *)WM_md5Uppercase;
- (NSString *)WM_base64;

@end
