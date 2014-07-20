//
//  HLYAutoLayoutTableManager.h
//  HuangLuyang
//
//  Created by huangluyang on 14-7-19.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLYAutoLayoutTableManager : NSObject

@property (nonatomic, copy) UITableViewCell* (^cellAtIndexPath)(NSIndexPath *indexPath);

- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath;

@end