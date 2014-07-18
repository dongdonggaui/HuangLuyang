//
//  HLYVideo.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-18.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYVideo.h"

@implementation HLYVideo

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"id"]) {
        self.vid = value;
    } else if ([key isEqualToString:@"category"]) {
        self.category = value;
    } else if ([key isEqualToString:@"comment_count"]) {
        self.commentCount = value;
    } else if ([key isEqualToString:@"down_count"]) {
        self.downCount = value;
    } else if ([key isEqualToString:@"duration"]) {
        self.duration = value;
    } else if ([key isEqualToString:@"favorite_count"]) {
        self.favoriteCount = value;
    } else if ([key isEqualToString:@"link"]) {
        self.link = value;
    } else if ([key isEqualToString:@"public_type"]) {
        self.publicType = value;
    } else if ([key isEqualToString:@"published"]) {
        self.published = value;
    } else if ([key isEqualToString:@"state"]) {
        self.state = value;
    } else if ([key isEqualToString:@"thumbnail"]) {
        self.thumbnail = value;
    } else if ([key isEqualToString:@"title"]) {
        self.title = value;
    } else if ([key isEqualToString:@"up_count"]) {
        self.upCount = value;
    } else if ([key isEqualToString:@"view_count"]) {
        self.viewCount = value;
    }
}

@end
