//
//  XTCalendarDataModel.h
//  XTCalendarView
//
//  Created by Tao.Xie on 2020/1/16.
//  Copyright © 2020 Tao.Xie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTCalendarDataModel : NSObject

@end

@interface XTCalendarMouthDataModel : NSObject

@property (nonatomic, assign) NSUInteger firstWeekday;
@property (nonatomic, assign) NSUInteger days;
@property (nonatomic, assign) NSUInteger weeks;
@property (nonatomic, assign) NSDate *date;

+ (instancetype)mouthWithDate:(NSDate *)date firstWeekday:(NSUInteger)firstWeekday days:(NSUInteger)days weeks:(NSUInteger)weeks;

@end


NS_ASSUME_NONNULL_END
