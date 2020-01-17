//
//  XTCalendarCell.m
//  XTCalendarView
//
//  Created by Tao.Xie on 2020/1/16.
//  Copyright © 2020 Tao.Xie. All rights reserved.
//

#import "XTCalendarCell.h"
#import "XTCalendar.h"

@interface XTCalendarCell ()

@property (weak, nonatomic) IBOutlet UIControl *bgView;

@property (nonatomic, copy) dispatch_block_t tapBlock;
@property (nonatomic, strong) NSDate *currentDate;
@end

@implementation XTCalendarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.borderWidth = 0.5;
    self.bgView.layer.borderColor = [UIColor grayColor].CGColor;
}

- (IBAction)tapDateAction:(id)sender {
    if (_tapBlock) {
        _tapBlock();
    }
}

- (void)displayCellByDataSource:(id)dataSource rowAtIndexPath:(NSIndexPath *)indexPath {
    if (!dataSource) return;
    XTCalendarMouthDataModel *mouth = dataSource;
    __weak typeof(self) weakSelf = self;

    NSInteger day = indexPath.row+2-mouth.firstWeekday;
    if (day > 0) {
        self.dateLabel.text = [NSString stringWithFormat:@"%ld", day];
        NSString *dateString = [NSString stringWithFormat:@"%@-%02ld",[XTCalendar stringWithDate:mouth.date], day];
        _currentDate = [XTCalendar dateWithString:dateString];
        self.tapBlock = ^{
            if (weakSelf.tapDateBlock) {
                weakSelf.tapDateBlock(weakSelf.currentDate);
            }
        };

    }else{
        self.dateLabel.text = @"";
        self.tapBlock = nil;
    }
}

- (void)checkStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    if (_dateLabel.text.length == 0) {
        self.bgView.backgroundColor = [UIColor whiteColor];
        return;
    }
    if ((startDate && [_currentDate compare:startDate] == NSOrderedSame) ||
        (endDate && [_currentDate compare:endDate] == NSOrderedSame)) {
        self.bgView.backgroundColor = [UIColor blueColor];
    }else if (startDate && endDate && [startDate compare:_currentDate] == NSOrderedAscending && [endDate compare:_currentDate] == NSOrderedDescending) {
        self.bgView.backgroundColor = [UIColor greenColor];
    }else{
        self.bgView.backgroundColor = [UIColor whiteColor];
    }
}

@end
