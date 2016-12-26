//
//  LLGetStep.m
//  FIndTheLight
//
//  Created by Wll on 16/12/5.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLGetStep.h"

@implementation LLGetStep


-(void)CreatHealth{
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
            [self ReadStep];
//            NSLog(@"结束%d",_LLUserStep)；

        }
        else
        {
            NSLog(@"获取步数权限失败");
        }
    }];
}

-(void)ReadStep{
    HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier: HKQuantityTypeIdentifierStepCount];
    //将healthStore的结果排序
    
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    //获取事件
    NSDate *now = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:now];
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    int second = (int)[dateComponent second];
    NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) ];
    //时间结果与想象中不同是因为它显示的是0区
//    NSLog(@"今天%@",nowDay);
    NSDate *nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400];
//    NSLog(@"明天%@",nextDay);
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
    
    /*
     查询的基类是HKQuery，这是一个抽象类，能够实现每一种查询目标，这里我们需要查询的步数是一个HKSample类所以对应的查询类是HKSampleQuery。下面的limit参数传1表示查询最近一条数据，查询多条数据只要设置limit的参数值就可以了
     */
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]initWithSampleType:sampleType predicate:predicate limit:0 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        //设置一个int型变量来作为步数统计
//        int allStepCount = 0;
//            _LLUserStep = 0 ;
        for (int i = 0; i < results.count; i ++) {

            //把结果转换为字符串类型
            HKQuantitySample *result = results[i];
            HKQuantity *quantity = result.quantity;
            NSMutableString *stepCount = (NSMutableString *)quantity;
            NSString *stepStr =[ NSString stringWithFormat:@"%@",stepCount];
            
            //获取51 count此类字符串前面的数字
            NSString *str = [stepStr componentsSeparatedByString:@" "][0];
            int stepNum = [str intValue];
            
//            NSLog(@"%d",stepNum);
            //把一天中所有时间段中的步数加到一起
            _LLUserStep = _LLUserStep + stepNum;
//            NSString *stepCountString = (NSString *)_LLUserStep;  
        }
//        NSString *todayEnergy = [[NSString alloc] initWithFormat:@"%d",_LLUserStep];
        NSString *oldtodayenergy = [[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"];
        int updateValue = [oldtodayenergy intValue];
        int AddEnergy = _LLUserStep - updateValue;
        NSLog(@"今天的步数%d 增加的步数%d",_LLUserStep,AddEnergy);
        
        NSString *newtodayEnergy = [NSString stringWithFormat:@"%d",_LLUserStep];
        [[NSUserDefaults standardUserDefaults]setValue:newtodayEnergy forKey:@"NowDayEnergy"];
//        NSString *oldtodayenergy2 = [[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"];
//        NSLog(@"%@",oldtodayenergy2);
        
        
        NSString *energy = [[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"];
        int energyValue = [energy intValue];
        int resultValue = AddEnergy + energyValue;
        NSString *result = [NSString stringWithFormat:@"%d",resultValue];
        NSLog(@"当前的能量%@",result);
        [[NSUserDefaults standardUserDefaults]setValue:result forKey:@"Energy"];
        
       
//        NSLog(@"在回调中%d",_LLUserStep);
       
        //查询要放在多线程中进行，如果要对UI进行刷新，要回到主线程
    }];
    
    //执行查询
    [self.HealthStore executeQuery:sampleQuery];
    
//    id energy = [[NSUserDefaults standardUserDefaults] objectForKey:@"Energy"];
//    NSLog(@"数据库中的%@",energy);
//    NSMutableArray *stepCount = [[NSMutableArray alloc]init];
//    [stepCount insertObject:_LLUserStep atIndex:0];
//    NSLog(@"回调结束%d",_LLUserStep);

    

    

}
@end
