//
//  NSString+Encrypt.m
//  WanmeiAD
//
//  Created by huangluyang on 14-7-4.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "NSString+Encrypt.h"

@implementation NSString (Encrypt)

+ (NSString *)WM_generateAppkeyWithColumnId:(NSString *)columnId appId:(NSString *)appid
{
    NSString *stringTobeCount = [columnId stringByAppendingString:appid];
    
    int charNum[62];
    for (int i = 0; i < 62; i++) {
        charNum[i] = 0;
    }
    
    int length = (int)stringTobeCount.length;
    for (int i = 0; i < length; i++) {
        char c = [stringTobeCount characterAtIndex:i];
        if (c >= 'a' && c <= 'z') {
            int n = 25 - c + 'a';       // 小写 ASCII 倒序
            charNum[n]++;
        } else if (c >= 'A' && c <= 'Z') {
            int n = 51 - c + 'A';       // 大写 ASCII 倒序
            charNum[n]++;
        } else if (c >= '0' && c <= '9') {
            int n = 61 - c + '0';       // 数字 ASCII 倒序
            charNum[n]++;
        }
    }
    
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:30];
    for (int i = 0; i < 62; i++) {
        if (charNum[i] > 0) {
            char c;
            if (i < 26) {
                c = 'z' - i;
            } else if (i >= 26 && i < 52) {
                c = 'Z' + 26 - i;
            } else {
                c = '9' + 52 - i;
            }
            [temp addObject:@{@"key": [NSString stringWithFormat:@"%c", c], @"value": [NSNumber numberWithInt:charNum[i]]}];
        }
    }
    
    [temp sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([[obj1 objectForKey:@"value"] integerValue] > [[obj2 objectForKey:@"value"] integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        if ([[obj1 objectForKey:@"value"] integerValue] < [[obj2 objectForKey:@"value"] integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableString *sb = [NSMutableString string];
    for (int i = 0; i < temp.count; i++) {
        [sb appendString:[[temp objectAtIndex:i] objectForKey:@"key"]];
    }
    
    return [[sb WM_base64] WM_md5Lowercase];
}

- (NSString *)WM_md5Lowercase
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)WM_md5Uppercase
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//- (NSString *)WM_base64
//{
//    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
//    
//    return [data base64EncodedString];
//}

@end
