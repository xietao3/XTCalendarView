//
//  XTCalendarCell.h
//  XTCalendarView
//
//  Created by Tao.Xie on 2020/1/16.
//  Copyright © 2020 Tao.Xie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTCalendarCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, copy) void(^tapDateBlock)(NSDate *);

- (void)displayCellByDataSource:(id)dataSource rowAtIndexPath:(NSIndexPath *)indexPath;

- (void)checkStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
@end

NS_ASSUME_NONNULL_END
