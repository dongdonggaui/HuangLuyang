//
//  HLYFriendInterviewViewController.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-17.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "HLYFriendInterviewViewController.h"

#import "NSDate+Display.h"
#import "NSString+Encrypt.h"
#import <UIImage+ImageWithColor.h>

@interface HLYFriendInterviewCell : UITableViewCell

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(NSDate *)time;

- (void)loadVideo;

@end

@implementation HLYFriendInterviewCell

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(NSDate *)time
{
    
}

- (void)loadVideo
{
    
}

@end

@interface HLYFriendVideoCell : HLYFriendInterviewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoShotImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIWebView *videoWebView;

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(NSDate *)time;
- (void)loadVideo;

@end

@implementation HLYFriendVideoCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(NSDate *)time
{
    self.videoShotImageView.image = imagePath ? [UIImage imageNamed:imagePath] : [UIImage imageWithColor:[UIColor lightGrayColor]];
    self.videoDescriptionLabel.text = description;
    self.timeLabel.text = [time HLY_shortDisplayFormat];
    
    
}

- (void)loadVideo
{
    NSString *vid = @"XMzY1MDcwNTk2";
    NSString *clientSecret = @"84fdceb93efe44e95323c7905dfb33c1";
    NSNumber *timestamp = [NSNumber numberWithLong:[[NSDate date] timeIntervalSince1970]];
    NSString *signature = [[NSString stringWithFormat:@"%@_%@_%@", vid, timestamp, clientSecret] WM_md5Lowercase];
    NSString *embsig = [NSString stringWithFormat:@"1_%@_%@", timestamp, signature];
    NSString *html = [NSString stringWithFormat:@"<html><body><div id=\"youkuplayer\" style=\"width:480px;height:400px\"></div><script type=\"text/javascript\" src=\"http://player.youku.com/jsapi\">player = new YKU.Player('youkuplayer',{styleid: '0',client_id: '472cc7c9b8111f50',vid: 'XMzY1MDcwNTk2',embsig: '%@',events:{onPlayEnd: function(){ /*your code*/ },onPlayStart: function(){ /*your code*/ },onPlayerReady: function(){ /*your code*/ }}});function playVideo(){player.playVideo();}function pauseVideo(){player.pauseVideo();}function seekTo(s){player.seekTo(s);}function currentTime(){return player.currentTime();}</script></body></html>", embsig];;
    [self.videoWebView loadHTMLString:html baseURL:nil];
}

@end

@interface HLYFriendVideoRearCell : HLYFriendInterviewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoShotImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(NSDate *)time;

@end

@implementation HLYFriendVideoRearCell

- (void)configureCellWithImagePath:(NSString *)imagePath description:(NSString *)description time:(NSDate *)time
{
    self.videoShotImageView.image = imagePath ? [UIImage imageNamed:imagePath] : [UIImage imageWithColor:[UIColor lightGrayColor]];
    self.videoDescriptionLabel.text = description;
    self.timeLabel.text = [time HLY_shortDisplayFormat];
}

@end


@interface HLYFriendInterviewViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *cellCache;

@end

@implementation HLYFriendInterviewViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    self.title = NSLocalizedString(@"朋友眼中", @"");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerReadyForDisplayDidChangeNotification:) name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerReadyForDisplayDidChangeNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerReadyForDisplayDidChangeNotification:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerReadyForDisplayDidChangeNotification:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cellCache = [NSMutableDictionary dictionary];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - private
- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath
{
    HLYFriendInterviewCell *cell = [self.cellCache objectForKey:@(indexPath.row)];
    if (!cell) {
        static NSString *videoCellIdentifier = @"videoCell";
        static NSString *videlRearCellIdentifier = @"videoRearCell";
        
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
    }
    [cell configureCellWithImagePath:nil description:@"朋友某某" time:[NSDate date]];
    [self.cellCache setObject:cell forKey:@(indexPath.row)];
    
    return cell;
}

- (void)moviePlayerReadyForDisplayDidChangeNotification:(NSNotification *)notification
{
    NSLog(@"movie player load state notification --> %@", notification);
}

#pragma mark -
#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self cellAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HLYFriendInterviewCell *cell = (HLYFriendInterviewCell *)[self cellAtIndexPath:indexPath];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraints];
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HLYFriendInterviewCell *cell = (HLYFriendInterviewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell loadVideo];
}

@end
