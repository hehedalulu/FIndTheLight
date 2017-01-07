//
//  LLGetNowTime.m
//  FIndTheLight
//
//  Created by Wll on 16/12/21.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLGetNowTime.h"

@implementation LLGetNowTime

-(NSDate *)LLGetNowTimeNSDate{
    
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    //输出currentDateString
    NSLog(@"%@",currentDateString);
    
    return currentDate;
}


-(NSDate *)LLGetOldTimeNSDate{
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"LLLastRecordTime"]) {
        NSString *LLLastRecordTimeString = [[NSUserDefaults standardUserDefaults] valueForKey:@"LLLastRecordTime"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //NSString转NSDate
        NSDate *LLLastRecordTime = [formatter dateFromString:LLLastRecordTimeString];
        return LLLastRecordTime;
    }else{
        NSDate *firstOpenDate = [[NSUserDefaults standardUserDefaults] valueForKey:@"firstOpenAPPString"];

        return firstOpenDate;
    }
}

-(long int)LLGetIntervalTime{
    
    NSDate *startDate = [self LLGetNowTimeNSDate];
    NSDate *endDate = [self LLGetOldTimeNSDate];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type   = NSCalendarUnitYear  |
                            NSCalendarUnitMonth |
                            NSCalendarUnitDay   |
                            NSCalendarUnitHour  |
                            NSCalendarUnitMinute|
                            NSCalendarUnitSecond;
    
    // 4.获取了时间元素
    NSDateComponents *cmps = [calendar components:type fromDate:endDate toDate:startDate options:0];
    
    NSLog(@"%ld年%ld月%ld日%ld小时%ld分钟%ld秒钟", (long)cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    long int yearsecond     = cmps.year*365*24*60*60;
    long int monthsecond    = cmps.month*30*24*60*60;
    long int daysecond      = cmps.day*24*60*60;
    long int hour           = cmps.hour*60*60;
    long int minute         = cmps.minute*60;
    long int second         = cmps.second;
    long int resultsecond   = yearsecond + monthsecond + daysecond + hour + minute + second;
    
//    NSDate *date = [NSDate date];
//    [[NSUserDefaults standardUserDefaults]setObject:date forKey:@"sss"];
//    
//    NSDate *nowdate = [[NSUserDefaults standardUserDefaults]valueForKey:@"sss"];
    
    if (resultsecond > 3600) {
        resultsecond = 3600;
    }
    return resultsecond;
}

@end
