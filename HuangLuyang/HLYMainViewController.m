//
//  HLYMainViewController.m
//  HuangLuyang
//
//  Created by huangluyang on 14-7-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "HLYMainViewController.h"
#import "HLYMainViewLayout.h"

@interface HLYMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation HLYMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.collectionView.alwaysBounceVertical = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - collection view data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *smallCellIdentifier = @"smallCell";
    static NSString *bigCellIdentifier = @"bigCell";
    
    UICollectionViewCell *cell = nil;
    if (indexPath.row == 3) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:bigCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:smallCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor purpleColor];
    }
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 1) {
        [self performSegueWithIdentifier:@"showFriendInterview" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"showStory" sender:nil];
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return CGSizeMake(280, 155);
    } else {
        return CGSizeMake(88, 88);
    }
}

@end
