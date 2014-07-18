//
//  HLYVideo.h
//  HuangLuyang
//
//  Created by huangluyang on 14-7-18.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLYVideo : NSObject

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSNumber *commentCount;
@property (nonatomic, strong) NSNumber *downCount;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSNumber *favoriteCount;
@property (nonatomic, strong) NSString *vid;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *publicType;
@property (nonatomic, strong) NSString *published;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *upCount;
@property (nonatomic, strong) NSNumber *viewCount;

@property (nonatomic, strong) NSArray *streamTypes;
@property (nonatomic, strong) NSArray *operationLimit;

@end
