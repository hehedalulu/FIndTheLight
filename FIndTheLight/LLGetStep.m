//
//  LLGetStep.m
//  FIndTheLight
//
//  Created by Wll on 16/12/5.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLGetStep.h"

@implementation LLGetStep


-(void)FirstCreatHealth{
    //先判断设备支不支持HealthKit
    if(![HKHealthStore isHealthDataAvailable]){
        NSLog(@"不支持HealthKit");
    }
    //创建HealthStore对象
    self.HealthStore = [[HKHealthStore alloc]init];
    //设置需要获取的权限 如果想用其他数据可以写别的type
    HKObjectType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSet *healthSet = [NSSet setWithObjects:stepType,nil];
    //用一个block来实现权限的获取
    [self.HealthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            //如果是第一次就第一次
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isFirst"]isEqualToString:@"YES"]) {
                [self firstTimeReadStep];
            }else{
                [self ReadAddStep];
            }
        }
        else
        {
            NSLog(@"获取步数权限失败");
        }
    }];
}

-(void)CreatAddHealth{
    if(![HKHealthStore isHealthDataAvailable]){
        NSLog(@"不支持HealthKit");
    }
    //创建HealthStore对象
    self.HealthStore = [[HKHealthStore alloc]init];
    //设置需要获取的权限 如果想用其他数据可以写别的type
    HKObjectType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSet *healthSet = [NSSet setWithObjects:stepType,nil];
    //用一个block来实现权限的获取
    [self.HealthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
                [self ReadAddStep];
        }
        else
        {
            NSLog(@"获取步数权限失败");
        }
    }];}


-(void)firstTimeReadStep{
    HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierStepCount];
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    //获取当前时间 并转成当地时间
    NSDate *GMTdate = [NSDate date]; // 获得时间对象
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    //    NSTimeInterval time = [zone secondsFromGMTForDate:GMTdate];// 以秒为单位返回当前时间与系统格林尼治时间的差
    //    NSDate *nowDate = [GMTdate dateByAddingTimeInterval:time];
    //    NSLog(@"可能是这里的问题 fromDate%@",GMTdate);
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:GMTdate];
    
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    int second = (int)[dateComponent second];
    NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) ];
    //时间结果与想象中不同是因为它显示的是0区
    //    NSLog(@"今天%@",nowDay);
    NSDate *nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400];
    //    NSLog(@"明天%@",nextDay);
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
    
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]initWithSampleType:sampleType predicate:predicate limit:0 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        //设置一个int型变量来作为步数统计
        for (int i = 0; i < results.count; i ++) {
            //把结果转换为字符串类型
            HKQuantitySample *result = results[i];
            HKQuantity *quantity = result.quantity;
            NSMutableString *stepCount = (NSMutableString *)quantity;
            NSString *stepStr =[NSString stringWithFormat:@"%@",stepCount];
            
            //获取51 count此类字符串前面的数字
            NSString *str = [stepStr componentsSeparatedByString:@" "][0];
            int stepNum = [str intValue];
            //            NSLog(@"%d",stepNum);
            //把一天中所有时间段中的步数加到一起
            _LLUserStep = _LLUserStep + stepNum;
        }
        NSString *FirstdayEnergy = [NSString stringWithFormat:@"%d",_LLUserStep];
        [[NSUserDefaults standardUserDefaults]setValue:FirstdayEnergy forKey:@"Energy"];
        [[NSUserDefaults standardUserDefaults]setValue:FirstdayEnergy forKey:@"NowDayEnergy"];
        NSLog(@"第一次打开时的能量值是%@,当天的能量是%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"],
              [[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"]);
    }];
    [self.HealthStore executeQuery:sampleQuery];
}

-(void)ReadAddStep{
    HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierStepCount];
    //将healthStore的结果排序
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    //获取当前时间 并转成当地时间
    NSDate *GMTdate = [NSDate date]; // 获得时间对象
//    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
//    NSTimeInterval time = [zone secondsFromGMTForDate:GMTdate];// 以秒为单位返回当前时间与系统格林尼治时间的差
//    NSDate *nowDate = [GMTdate dateByAddingTimeInterval:time];
//    NSLog(@"可能是这里的问题 fromDate%@",GMTdate);
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:GMTdate];
    
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    int second = (int)[dateComponent second];
    NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) ];
    //时间结果与想象中不同是因为它显示的是0区
//    NSLog(@"今天%@",nowDay);
    NSDate *nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400];
//    NSLog(@"明天%@",nextDay);
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]initWithSampleType:sampleType predicate:predicate limit:0 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        //设置一个int型变量来作为步数统计
        for (int i = 0; i < results.count; i ++) {
            //把结果转换为字符串类型
            HKQuantitySample *result = results[i];
            HKQuantity *quantity = result.quantity;
            NSMutableString *stepCount = (NSMutableString *)quantity;
            NSString *stepStr =[ NSString stringWithFormat:@"%@",stepCount];
            
            //获取51 count此类字符串前面的数字
            NSString *str = [stepStr componentsSeparatedByString:@" "][0];
            int stepNum = [str intValue];
            _LLUserStep = _LLUserStep + stepNum;
        }
        NSString *oldtodayenergy = [[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"];
        int oldtodayValue = [oldtodayenergy intValue];
        int AddEnergy = _LLUserStep - oldtodayValue;
        NSLog(@"今天现在的步数%d 增加的步数%d",_LLUserStep,AddEnergy);
        NSString *newtodayValue = [NSString stringWithFormat:@"%d",_LLUserStep];
        [[NSUserDefaults standardUserDefaults]setValue:newtodayValue forKey:@"NowDayEnergy"];
        
        //加当天差值加入Energy
        NSString *tempEnergy = [[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"];
        int tempValue = [tempEnergy intValue];
        int resultValue = tempValue + AddEnergy;
        NSLog(@"当前的能量%d",resultValue);
        NSString *resultEnergy = [NSString stringWithFormat:@"%d",resultValue];
        [[NSUserDefaults standardUserDefaults]setValue:resultEnergy forKey:@"Energy"];
    }];
    
    //执行查询
    [self.HealthStore executeQuery:sampleQuery];

}
@end
