//
//  HLYFriendInterviewViewController.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-17.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "HLYFriendInterviewViewController.h"
#import "HLYVideoManager.h"
#import "HLYAutoLayoutTableManager.h"

#import "HLYVideo.h"

#import "NSDate+Display.h"
#import "NSString+Encrypt.h"
#import "UIImageView+Network.h"
#import <UIImage+ImageWithColor.h>

@interface HLYFriendInterviewCell : UITableViewCell

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(id)time;

@end

@implementation HLYFriendInterviewCell

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(id)time
{
    
}

@end

@interface HLYFriendVideoCell : HLYFriendInterviewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoShotImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(id)time;

@end

@implementation HLYFriendVideoCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(id)time
{
    [self.videoShotImageView HLY_loadNetworkImageAtPath:imagePath];
    self.videoDescriptionLabel.text = description;
    self.timeLabel.text = [time isKindOfClass:[NSDate class]] ? [time HLY_shortDisplayFormat] : time;
    
    
}

@end

@interface HLYFriendVideoRearCell : HLYFriendInterviewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoShotImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(id)time;

@end

@implementation HLYFriendVideoRearCell

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(id)time
{
    [self.videoShotImageView HLY_loadNetworkImageAtPath:imagePath];
    self.videoDescriptionLabel.text = description;
    self.timeLabel.text = [time isKindOfClass:[NSDate class]] ? [time HLY_shortDisplayFormat] : time;
}

@end


@interface HLYFriendInterviewViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *cellCache;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) HLYAutoLayoutTableManager *tableManager;

@end

@implementation HLYFriendInterviewViewController

- (void)dealloc
{
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    self.title = NSLocalizedString(@"朋友眼中", @"");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cellCache = [NSMutableDictionary dictionary];
    
    __weak HLYFriendInterviewViewController *safeSelf = self;
    
    self.tableManager = [[HLYAutoLayoutTableManager alloc] init];
    self.tableManager.cellAtIndexPath = ^UITableViewCell* (NSIndexPath *indexPath) {
        return [safeSelf cellAtIndexPath:indexPath];
    };
    
    [[HLYVideoManager sharedInstance] fetchVideoListSuccess:^(NSArray *videos) {
        safeSelf.datas = videos;
        [safeSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - private
- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.datas != nil && self.datas.count == 0) {
//        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"nullCell"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nullCell"];
//        }
//        cell.textLabel.text = NSLocalizedString(@"暂无数据", @"");
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.userInteractionEnabled = NO;
//        
//        return cell;
//    }
//    
//    HLYFriendInterviewCell *cell = [self.cellCache objectForKey:@(indexPath.row)];
//    if (!cell) {
//        static NSString *videoCellIdentifier = @"videoCell";
//        static NSString *videlRearCellIdentifier = @"videoRearCell";
//        
//        if (indexPath.row != 2) {
//            cell = (HLYFriendVideoCell *)[self.tableView dequeueReusableCellWithIdentifier:videoCellIdentifier];
//            if (!cell) {
//                cell = [[HLYFriendVideoCell alloc] init];
//            }
//        } else {
//            cell = (HLYFriendVideoRearCell *)[self.tableView dequeueReusableCellWithIdentifier:videlRearCellIdentifier];
//            if (!cell) {
//                cell = [[HLYFriendVideoRearCell alloc] init];
//            }
//        }
//    }
//    HLYVideo *video = [self.datas objectAtIndex:indexPath.row];
//    
//    [cell configureCellWithImagePath:video.thumbnail description:video.title time:video.published];
//    [self.cellCache setObject:cell forKey:@(indexPath.row)];
//    
//    return cell;
    
    static NSString *videoCellIdentifier = @"videoCell";
    static NSString *videlRearCellIdentifier = @"videoRearCell";
    
    HLYFriendInterviewCell *cell = nil;
    if (indexPath.row != 2) {
        cell = (HLYFriendVideoCell *)[self.tableView dequeueReusableCellWithIdentifier:videoCellIdentifier];
        if (!cell) {
            cell = [[HLYFriendVideoCell alloc] init];
        }
    } else {
        cell = (HLYFriendVideoRearCell *)[self.tableView dequeueReusableCellWithIdentifier:videlRearCellIdentifier];
        if (!cell) {
            cell = [[HLYFriendVideoRearCell alloc] init];
        }
    }
    HLYVideo *video = [self.datas objectAtIndex:indexPath.row];
    
    [cell configureCellWithImagePath:video.thumbnail description:video.title time:video.published];
    
    return cell;
}

#pragma mark -
#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[HLYViewController class]]) {
        HLYViewController *vc = segue.destinationViewController;
        vc.passValue = sender;
    }
}

#pragma mark -
#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas != nil && self.datas.count == 0 ? 1 : self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    return [self cellAtIndexPath:indexPath];
    return [self.tableManager cellAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    HLYFriendInterviewCell *cell = (HLYFriendInterviewCell *)[self cellAtIndexPath:indexPath];
//    
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraints];
//    [cell.contentView setNeedsLayout];
//    [cell.contentView layoutIfNeeded];
//    
//    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    
//    return height;
    
    return [self.tableManager heightForCellAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HLYVideo *video = [self.datas objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showPlayer" sender:video];
}

@end
