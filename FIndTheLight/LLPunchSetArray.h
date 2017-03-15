//
//  LLPunchSetArray.h
//  FIndTheLight
//
//  Created by Wll on 17/2/10.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface LLPunchSetArray : NSObject
{
    NSMutableArray *StepsArray;
    NSDateFormatter *normalFormatter;
    int initStepsDay;
}
@property(nonatomic,strong) HKHealthStore *LLPunchHealthStore;

-(NSMutableArray *)setDayArrayWithDate:(NSDate *)date;

-(NSMutableArray *)setWeekArrayWithDate:(NSDate *)date;

-(NSMutableArray *)setDateArrayWithDate:(NSDate *)date;

-(NSMutableArray *)setStepsArrayWithDaysCount:(int)DaysCount Date:(NSDate *)date;

-(NSMutableArray *)UpStepsArrayWithDaysCount:(int)DaysCount Date:(NSDate *)date;

-(NSMutableArray *)newStepsArrayWithDaysCount:(int)DaysCount Date:(NSDate *)date;


@property (nonatomic) NSDate *LLPunchinitday;
@end
