//
//  LLStepsManger.m
//  FIndTheLight
//
//  Created by Wll on 17/3/11.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLStepsManger.h"

@implementation LLStepsManger

-(void)initLLStepsModel{
    StepHealthRealm =  [RLMRealm defaultRealm];
    StepDayFormatter = [[NSDateFormatter alloc]init];
    StepDayFormatter.dateFormat = @"yyyy-MM-dd";
    StepWeekFormatter = [[NSDateFormatter alloc]init];
    StepWeekFormatter.dateFormat = @"EEEE";
    StepDateFormatter = [[NSDateFormatter alloc]init];
    StepDateFormatter.dateFormat = @"dd";
    
    
    NSString *olddateStr = @"2017-01-01";
    NSDate *olddate = [StepDayFormatter dateFromString:olddateStr];
    NSDate *now = [NSDate date];
    int intervaldays = [self CalDate:olddate WithNewDate:now];
    
    [self searchStepsWithDays:(long)intervaldays];
    
    
    [self setDate:intervaldays WithDate:olddate];
   
    
}

-(int)CalDate:(NSDate *)olddate WithNewDate:(NSDate*)now{
    NSTimeInterval intervaltime = [now timeIntervalSinceDate:olddate];
    int days = ((int)intervaltime)/(3600*24);
    NSLog(@"距2017-01－01相差%d天",days);
    return days;
}



#pragma mark -  添加日期 星期几
-(void)setDate:(int)IntervalDate WithDate:(NSDate *)date{
//    NSDate *todayzero = [self TodayzeroTime];
    for (int i = 0; i<=IntervalDate; i++) {
        NSTimeInterval  interval = 24*60*60*i; //1:天数
        NSDate *addDate = [date dateByAddingTimeInterval:interval];
        NSString *DateString = [NSString stringWithFormat:@"%@",[StepDayFormatter stringFromDate:addDate]];
        //转换成周几
        NSString *Weekday = [NSString stringWithFormat:@"%@",[StepWeekFormatter stringFromDate:addDate]];
        NSString *WeekdayString = [self ChangeToWeekString:Weekday];
        
        NSString *dayString = [NSString stringWithFormat:@"%@",[StepDateFormatter stringFromDate:addDate]];
        
        LLEveryDaystep *model = [[LLEveryDaystep alloc]init];
        model.LLEverydayDate = DateString;
        model.LLEverydayWeekday = WeekdayString;
        model.LLEveryDateString = dayString;
        model.LLEverydayStep = [[NSUserDefaults standardUserDefaults]valueForKey:[NSString stringWithFormat:@"%@Step",[StepDayFormatter stringFromDate:addDate]]];
        model.HasLogthisday = @"0";
        
        [StepHealthRealm beginWriteTransaction];
        [LLEveryDaystep createOrUpdateInRealm:StepHealthRealm withValue:model];
        [StepHealthRealm commitWriteTransaction];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [StepHealthRealm transactionWithBlock:^{
//                [StepHealthRealm addObject: model];
//                [StepHealthRealm commitWriteTransaction];
//            }];
            NSLog(@"添加到数据库");
//        });
    }
    ;
    
}

-(NSString *)ChangeToWeekString:(NSString *)WeekString{
    if ([WeekString isEqualToString:@"星期一"]) {
        return @"周一";
    }else if ([WeekString isEqualToString:@"星期二"]){
        return @"周二";
    }else if ([WeekString isEqualToString:@"星期三"]){
        return @"周三";
    }else if ([WeekString isEqualToString:@"星期四"]){
        return @"周四";
    }else if ([WeekString isEqualToString:@"星期五"]){
        return @"周五";
    }else if ([WeekString isEqualToString:@"星期六"]){
        return @"周六";
    }else{
        return @"周日";
    }
}




-(NSDate *)TodayzeroTime{
    //获取当前时间 并转成当地时间
    NSDate *GMTdate = [NSDate date]; // 获得时间对象
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:GMTdate];
    
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    int second = (int)[dateComponent second];
    
    NSDate *today = [GMTdate dateByAddingTimeInterval: - (hour*3600 + minute * 60 + second)];
    return today;
    

}


#pragma mark -  查询步数 添加步数

/******
 从第一天使用这个APP开始记录 一直查询到每一天的步数
 ******/
-(void)searchStepsWithDays:(long)DayCount{
    StepDayFormatter = [[NSDateFormatter alloc]init];
    StepDayFormatter.dateFormat = @"yyyy-MM-dd";
    
    //先判断设备支不支持HealthKit
    if(![HKHealthStore isHealthDataAvailable]){
        NSLog(@"不支持HealthKit");
    }
    //创建HealthStore对象
    LLStepHealthStore = [[HKHealthStore alloc]init];
    //设置需要获取的权限 如果想用其他数据可以写别的type
    HKObjectType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSet *healthSet = [NSSet setWithObjects:stepType,nil];
    //用一个block来实现权限的获取
    [LLStepHealthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            
            //获取当前时间 并转成当地时间
            NSDate *GMTdate = [NSDate date]; // 获得时间对象
            NSCalendar *calender = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *dateComponent = [calender components:unitFlags fromDate:GMTdate];
            
            int hour = (int)[dateComponent hour];
            int minute = (int)[dateComponent minute];
            int second = (int)[dateComponent second];
            
            NSDate *today = [GMTdate dateByAddingTimeInterval: - (hour*3600 + minute * 60 + second)];
            //                NSDate *today = [NSDate date];
            
            for (int i = (int)DayCount; i >= -1; i--) {
                NSDate *nextdate = [today dateByAddingTimeInterval:-86400*i];
                //                    NSLog(@"在%@查询",nextdate);
                [self ReadStepsByOlddate:nextdate];
            }
        }
        else
        {
            NSLog(@"获取步数权限失败");
        }
    }];
    
}

-(void)ReadStepsByOlddate:(NSDate *)oldDate{
    HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierStepCount];
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    NSDate *nextDay = [oldDate dateByAddingTimeInterval: + 86400];
    //    NSLog(@"明天%@",nextDay);
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:oldDate endDate:nextDay options:(HKQueryOptionNone)];
    
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]initWithSampleType:sampleType predicate:predicate limit:0 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        //设置一个int型变量来作为步数统计
        int count = 0 ;
        for (int i = 0; i < results.count; i ++) {
            //把结果转换为字符串类型
            HKQuantitySample *result = results[i];
            HKQuantity *quantity = result.quantity;
            NSMutableString *stepCount = (NSMutableString *)quantity;
            NSString *stepStr =[NSString stringWithFormat:@"%@",stepCount];
            
            //获取51 count此类字符串前面的数字
            NSString *str = [stepStr componentsSeparatedByString:@" "][0];
            int stepNum = [str intValue];
            count = count +stepNum;
            //把一天中所有时间段中的步数加到一起
        }
//        NSLog(@"%d",count);

//
        
//        LLEveryDaystep *model = [[LLEveryDaystep alloc]init];
        
        NSString *StepsCount = [NSString stringWithFormat:@"%d",count];
        NSString *SaveNameString = [NSString stringWithFormat:@"%@Step",[StepDayFormatter stringFromDate:oldDate]];
        //        NSLog(@"步数存储的key%@",SaveNameString);
        
        [[NSUserDefaults standardUserDefaults]setObject:StepsCount forKey:SaveNameString];
        
        
    }];
    [LLStepHealthStore executeQuery:sampleQuery];
    
}

@end
