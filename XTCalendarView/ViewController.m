//
//  ViewController.m
//  XTCalendarView
//
//  Created by Tao.Xie on 2020/1/16.
//  Copyright © 2020 Tao.Xie. All rights reserved.
//

#define kScreenSize [UIScreen mainScreen].bounds.size

#import "ViewController.h"
#import "XTCalendar.h"
#import "XTCalendarCell.h"
#import "XTCalendarHeaderView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@property (nonatomic, strong) NSMutableArray *mouths;
@property (nonatomic, strong) XTCalendarMouthDataModel *currentMouth;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mCollectionView registerNib:[UINib nibWithNibName:@"XTCalendarCell" bundle:nil] forCellWithReuseIdentifier:@"XTCalendarCell"];
    [_mCollectionView registerNib:[UINib nibWithNibName:@"XTCalendarHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XTCalendarHeaderView"];
    _mouths = [NSMutableArray new];
    [self getCurrentMouth];
    for (int i = 0; i< 11; i++) {
        [self getNextMouth];
    }
}

- (void)getCurrentMouth {
    _currentMouth = [XTCalendar mouthWithDate:[XTCalendar startDateForDate:[NSDate date]]];
    [_mouths addObject:_currentMouth];
}

- (void)getNextMouth {
    _currentMouth = [XTCalendar mouthWithDate:[XTCalendar getNextMouthWithDate:_currentMouth.date]];
    [_mouths addObject:_currentMouth];
    [_mCollectionView reloadData];
}

- (void)calcStartOrEndDate:(NSDate *)date {
    if ((_startDate == nil && _endDate == nil) ||
        (_startDate && _endDate) ||
        (_startDate && _endDate == nil && [_startDate compare:date] == NSOrderedDescending)) {
        _startDate = date;
        _endDate = nil;
        NSLog(@"1");
    }else{
        _endDate = date;
        NSLog(@"2");
    }
    [_mCollectionView reloadData];
}


#pragma mark -- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _mouths.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    XTCalendarMouthDataModel *mouth = [_mouths objectAtIndex:section];
    return mouth.days+mouth.firstWeekday-1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //[_collectionView registerNib:[UINib nibWithNibName:@"FDBaiKeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"baiKeCollectionViewCellIdentifier"];
    
    static NSString * cellIdentifier = @"XTCalendarCell";
    XTCalendarCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    XTCalendarMouthDataModel *mouth = [_mouths objectAtIndex:indexPath.section];
    [cell displayCellByDataSource:mouth rowAtIndexPath:indexPath];
    [cell checkStartDate:_startDate endDate:_endDate];
    __weak typeof(self) weakSelf = self;
    cell.tapDateBlock = ^(NSDate * _Nonnull date) {
        [weakSelf calcStartOrEndDate:date];
    };
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.frame.size.width, 50);
}
 
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {

        XTCalendarHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XTCalendarHeaderView" forIndexPath:indexPath];
        XTCalendarMouthDataModel *mouth = [_mouths objectAtIndex:indexPath.section];

        headerView.titleLabel.text = [XTCalendar stringWithDate:mouth.date];
        reusableview = headerView;
    }
    return reusableview;
}

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(floor((kScreenSize.width-20)/7.0), 40);
    
}
    

@end
