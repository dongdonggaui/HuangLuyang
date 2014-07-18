//
//  HLYVideoManager.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-18.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYVideoManager.h"
#import "HLYVideo.h"
#import "NSString+Encrypt.h"

#define kYoukuAppKey @"472cc7c9b8111f50"
#define kYoukuAppScrect @"84fdceb93efe44e95323c7905dfb33c1"
#define kYoukuRedirectUri @"http://u.youku.com/%E6%B4%9E%E5%A6%96%E6%88%91%E6%98%AF%E5%8A%A8%E6%8B%90"
#define kYoukuRedirectUriChinese @"http://u.youku.com/洞妖我是动拐"
#define kYoukuCallbackUrl @"http://i.youku.com/u/id_UMTM2NjEzOTg4"
#define kApiYoukuBasePath @"https://openapi.youku.com"

@implementation HLYVideoManager

+ (instancetype)sharedInstance
{
    static HLYVideoManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedManager) {
            sharedManager = [[HLYVideoManager alloc] initWithBaseURL:[NSURL URLWithString:kApiYoukuBasePath]];
        }
    });
    
    return sharedManager;
}

- (NSString *)playerHTMLWithVideoId:(NSString *)vid
{
    double timeStamp = [[NSDate date] timeIntervalSince1970];
    NSString *toBeMD5 = [NSString stringWithFormat:@"%@_%lf_%@", vid, timeStamp, kYoukuAppScrect];
    NSString *embsig = [NSString stringWithFormat:@"%@_%lf_%@", @"1", timeStamp, [toBeMD5 HLY_md5Lowercase]];
    NSString *html = [NSString stringWithFormat:@"<div id=\"youkuplayer\"></div><script type=\"text/javascript\" src=\"http://player.youku.com/jsapi\">player = new YKU.Player('youkuplayer',{client_id: '%@',vid: '%@',autoplay: false,embsig: '%@',show_related: false,width: 300,height: 200,events:{onPlayerReady: function(){ /*your code*/ },onPlayStart: function(){ /*your code*/ },onPlayEnd: function(){ /*your code*/ }}});</script>", kYoukuAppKey, vid, embsig];
    
    return html;
}

- (void)fetchVideoListSuccess:(void (^)(NSArray *))success
                      failure:(void (^)(NSError *))failure
{
    NSDictionary *properties = @{@"user_id": @"UMTM2NjEzOTg4",
                                 @"client_id": kYoukuAppKey};
    [self GET:@"/v2/videos/by_user.json" parameters:properties success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *dics = [responseObject objectForKey:@"videos"];
            NSMutableArray *videos = [NSMutableArray arrayWithCapacity:dics.count];
            for (NSDictionary *dic in dics) {
                HLYVideo *video = [[HLYVideo alloc] init];
                [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    [video setValue:obj forKey:key];
                }];
                [videos addObject:video];
            }
            
            if (success) {
                success(videos);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
