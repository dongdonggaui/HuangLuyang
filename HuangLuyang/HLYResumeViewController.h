//
//  HLYResumeViewController.h
//  HuangLuyang
//
//  Created by huangluyang on 14-7-19.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYViewController.h"

@interface HLYResumeViewController : HLYViewController

@end

@interface HLYCompanyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)configureCellWithTitle:(NSString *)title
                   companyName:(NSString *)companyName
                          date:(NSDate *)date
                       content:(NSString *)content;

@end

@interface HLYEducationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)configureCellWithSchoolName:(NSString *)schoolName
                     departmentName:(NSString *)departmentName
                               date:(NSDate *)date;

@end
