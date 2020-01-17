//
//  XTCalendar.h
//  XTCalendarView
//
//  Created by Tao.Xie on 2020/1/16.
//  Copyright © 2020 Tao.Xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTCalendarDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XTCalendar : NSObject

@property (nonatomic, strong) NSCalendar *calendar;

+ (XTCalendarMouthDataModel *)mouthWithDate:(NSDate *)date;

+ (NSDate *)dateWithString:(NSString *)string;
+ (NSString *)stringWithDate:(NSDate *)date;

+ (NSDate *)getNextMouthWithDate:(NSDate *)date;

+ (NSDate *)startDateForDate:(NSDate *)date;

@end


NS_ASSUME_NONNULL_END
