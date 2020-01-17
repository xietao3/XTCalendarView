//
//  XTCalendar.m
//  XTCalendarView
//
//  Created by Tao.Xie on 2020/1/16.
//  Copyright © 2020 Tao.Xie. All rights reserved.
//

#import "XTCalendar.h"

@interface XTCalendar ()


@end

@implementation XTCalendar

+ (instancetype)shareCalendar {
    static XTCalendar *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[XTCalendar alloc] init];
    });
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _calendar = [NSCalendar currentCalendar];
        [_calendar setFirstWeekday:2];
    }
    return self;
}

+ (XTCalendarMouthDataModel *)mouthWithDate:(NSDate *)date {
    NSCalendar *calendar = [XTCalendar shareCalendar].calendar;
    NSUInteger weekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSRange weeks = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
    XTCalendarMouthDataModel *mouth = [XTCalendarMouthDataModel mouthWithDate:date firstWeekday:weekday days:days.length weeks:weeks.length];
    return mouth;
}

+ (NSDate *)dateWithString:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+ (NSString *)stringWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *string = [formatter stringFromDate:date];
    return string;
}

+ (NSDate *)getNextMouthWithDate:(NSDate *)date {
    NSCalendar *calendar = [XTCalendar shareCalendar].calendar;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:1];
    NSDate *mDate = [calendar dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

+ (NSDate *)startDateForDate:(NSDate *)date {
    NSCalendar *calendar = [XTCalendar shareCalendar].calendar;
    NSDate *firstDate = nil;
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDate interval:nil forDate:date];
    
    return OK?firstDate:nil;
}




@end
