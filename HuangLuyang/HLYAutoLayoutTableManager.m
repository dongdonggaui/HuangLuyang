//
//  HLYAutoLayoutTableManager.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-19.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYAutoLayoutTableManager.h"

@interface HLYAutoLayoutTableManager ()

@property (nonatomic, strong) NSMutableDictionary *cellCache;

@end

@implementation HLYAutoLayoutTableManager

- (void)dealloc
{
    self.cellCache = nil;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.cellCache = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath) {
        return nil;
    }
    
    NSString *cellKey = [NSString stringWithFormat:@"%d-%d", (int)indexPath.section, (int)indexPath.row];
    UITableViewCell *cell = [self.cellCache objectForKey:cellKey];
    if (!cell) {
        if (self.cellAtIndexPath) {
            cell = self.cellAtIndexPath(indexPath);
            if (cell) {
                [self.cellCache setObject:cell forKey:cellKey];
            }
        }
    }
    
    return cell;
}

- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self cellAtIndexPath:indexPath];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraints];
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height;
}

@end
