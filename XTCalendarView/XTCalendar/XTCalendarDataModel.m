//
//  XTCalendarDataModel.m
//  XTCalendarView
//
//  Created by Tao.Xie on 2020/1/16.
//  Copyright © 2020 Tao.Xie. All rights reserved.
//

#import "XTCalendarDataModel.h"

@implementation XTCalendarDataModel

@end

@implementation XTCalendarMouthDataModel

+ (instancetype)mouthWithDate:(NSDate *)date firstWeekday:(NSUInteger)firstWeekday days:(NSUInteger)days weeks:(NSUInteger)weeks {
    XTCalendarMouthDataModel *mouth = [XTCalendarMouthDataModel new];
    mouth.date = date;
    mouth.firstWeekday = firstWeekday;
    mouth.weeks = weeks;
    mouth.days = days;
    return mouth;
}

@end
