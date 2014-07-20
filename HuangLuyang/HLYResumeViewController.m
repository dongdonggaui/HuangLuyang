//
//  HLYResumeViewController.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-19.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYResumeViewController.h"
#import "HLYAutoLayoutTableManager.h"

#import "HLYResumeCompany.h"
#import "HLYResumeEducation.h"

#import "NSDate+Display.h"

@interface HLYResumeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) HLYAutoLayoutTableManager *tableManager;
@property (nonatomic, strong) NSMutableArray *companies;
@property (nonatomic, strong) NSMutableArray *schools;

@end

@implementation HLYResumeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.title = NSLocalizedString(@"简历", @"");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //FIXME: test
    HLYResumeCompany *company1 = [[HLYResumeCompany alloc] init];
    company1.title = @"工程师";
    company1.companyName = @"完美世界";
    company1.date = [NSDate date];
    company1.content = @"SDK开发";
    
//    HLYResumeCompany *company2 = [[HLYResumeCompany alloc] init];
//    company2.title = @"工程师";
//    company2.companyName = @"完美世界";
//    company2.date = [NSDate date];
//    company2.content = @"SDK开发";
//    
//    HLYResumeCompany *company3 = [[HLYResumeCompany alloc] init];
//    company3.title = @"工程师";
//    company3.companyName = @"完美世界";
//    company3.date = [NSDate date];
//    company3.content = @"SDK开发";
    
    self.companies = [NSMutableArray arrayWithObjects:company1, nil];
    
//    HLYResumeEducation *school1 = [[HLYResumeEducation alloc] init];
//    school1.schoolName = @"武汉大学";
//    school1.departmentName = @"国际软件学院软件工程系国际软件学院软件工程系国际软件学院软件工程系国际软件学院软件工程系";
//    school1.date = [NSDate date];
    
    HLYResumeEducation *school2 = [[HLYResumeEducation alloc] init];
    school2.schoolName = @"武汉大学";
    school2.departmentName = @"工程硕士学位——国际软件学院软件工程系";
    school2.date = [NSDate date];
    
    HLYResumeEducation *school3 = [[HLYResumeEducation alloc] init];
    school3.schoolName = @"武汉理工大学";
    school3.departmentName = @"工学学士学位——机电工程学院工业工程系";
    school3.date = [NSDate date];
    
    self.schools = [NSMutableArray arrayWithObjects:school2, school3, nil];
    
    __weak HLYResumeViewController *safeSelf = self;
    self.tableManager = [[HLYAutoLayoutTableManager alloc] init];
    self.tableManager.cellAtIndexPath = ^UITableViewCell* (NSIndexPath *indexPath) {
        static NSString *companyCellIdentifier = @"workCell";
        static NSString *educationCellIdentifier = @"educationCell";
        if (0 == indexPath.section) {
            HLYCompanyCell *cell = (HLYCompanyCell *)[safeSelf.tableView dequeueReusableCellWithIdentifier:companyCellIdentifier];
            if (!cell) {
                cell = [[HLYCompanyCell alloc] init];
            }
            HLYResumeCompany *company = [safeSelf.companies objectAtIndex:indexPath.row];
            [cell configureCellWithTitle:company.title companyName:company.companyName date:company.date content:company.content];
            
            return cell;
            
        } else {
            HLYEducationCell *cell = (HLYEducationCell *)[safeSelf.tableView dequeueReusableCellWithIdentifier:educationCellIdentifier];
            if (!cell) {
                cell = [[HLYEducationCell alloc] init];
            }
            HLYResumeEducation *school = [safeSelf.schools objectAtIndex:indexPath.row];
            [cell configureCellWithSchoolName:school.schoolName departmentName:school.departmentName date:school.date];
            
            return cell;
            
        }
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [safeSelf.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - private

#pragma mark -
#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? self.companies.count : self.schools.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableManager cellAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableManager heightForCellAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    switch (section) {
        case 0:
            title = NSLocalizedString(@"工作经历", @"");
            break;
            
        case 1:
            title = NSLocalizedString(@"教育背景", @"");
            break;
            
        default:
            title = @"";
            break;
    }
    
    return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}


@end


@implementation HLYCompanyCell

- (void)configureCellWithTitle:(NSString *)title companyName:(NSString *)companyName date:(NSDate *)date content:(NSString *)content
{
    self.titleLabel.text = title;
    self.companyLabel.text = companyName;
    self.dateLabel.text = [date HLY_shortDisplayFormat];
    self.contentLabel.text = content;
}

@end

@implementation HLYEducationCell

- (void)configureCellWithSchoolName:(NSString *)schoolName departmentName:(NSString *)departmentName date:(NSDate *)date
{
    self.schoolLabel.text = schoolName;
    self.departmentLabel.text = departmentName;
    self.dateLabel.text = [date HLY_shortDisplayFormat];
}



@end
