//
//  LLPunchSetArray.m
//  FIndTheLight
//
//  Created by Wll on 17/2/10.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLPunchSetArray.h"

@implementation LLPunchSetArray

-(NSMutableArray *)setDayArrayWithDate:(NSDate *)date{
    NSMutableArray *DayArray = [[NSMutableArray alloc]init];

    
    NSDateFormatter *dayformater = [[NSDateFormatter alloc]init];
    dayformater.dateFormat = @"dd";

    for (int i = 19; i >= 0; i--) {
        NSTimeInterval  interval = - 24*60*60*i; //1:天数
        NSDate *addDate = [date dateByAddingTimeInterval:interval];
        NSString *addString = [NSString stringWithFormat:@"%@",[dayformater stringFromDate:addDate]];
        [DayArray addObject:addString];
    }
//    NSLog(@"%@",DayArray);
    
    return DayArray;
}


-(NSMutableArray *)setWeekArrayWithDate:(NSDate *)date{
    NSMutableArray *WeekArray = [[NSMutableArray alloc]init];

    
    NSDateFormatter *dayformater = [[NSDateFormatter alloc]init];
    dayformater.dateFormat = @"eeee";
    
    for (int i = 19; i >= 0; i--) {
        NSTimeInterval  interval = - 24*60*60*i; //1:天数
        NSDate *addDate = [date dateByAddingTimeInterval:interval];
        NSString *addString = [NSString stringWithFormat:@"%@",[dayformater stringFromDate:addDate]];
        [WeekArray addObject:addString];
    }
//    NSLog(@"%@",WeekArray);
   
    
    return WeekArray;
}


-(NSMutableArray *)setStepsArrayWithDaysCount:(int)DaysCount Date:(NSDate *)date{
    StepsArray = [[NSMutableArray alloc]init];
    normalFormatter.dateFormat = @"yyyy-MM-dd";
//    _LLPunchinitday = date;
//    initStepsDay = DaysCount;
    [self searchStepsWithDays:DaysCount];
    
//    for (int i = DaysCount; i>= 1; i--) {
//        NSDate *day = [date dateByAddingTimeInterval:-86400*i];
//        NSString *SearchName = [NSString stringWithFormat:@"%@Step",[normalFormatter stringFromDate:day]];
//        NSString *steps = [[NSUserDefaults standardUserDefaults]valueForKey:SearchName];
//        [StepsArray addObject:steps];
//    }
//    NSLog(@"%@",StepsArray);
//   

//    [self performSelector:@selector(SaveInStepsCount) withObject:nil afterDelay:1.0];
    
    return StepsArray;
}



-(void)SaveInStepsCount{
    
        for (int i = initStepsDay; i>= 1; i--) {
            NSDate *day = [_LLPunchinitday dateByAddingTimeInterval:-86400*i];
            NSString *SearchName = [NSString stringWithFormat:@"%@Step",[normalFormatter stringFromDate:day]];
            NSString *steps = [[NSUserDefaults standardUserDefaults]valueForKey:SearchName];
            [StepsArray addObject:steps];
        }
        NSLog(@"%@",StepsArray);
//        if( [[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"]){
//            NSString *todayStep = [[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"];
//            [StepsArray addObject:todayStep];
//        }else{
//            NSString *todayStep = @"00";
//            [StepsArray addObject:todayStep];
//        }
}


-(NSMutableArray *)UpStepsArrayWithDaysCount:(int)DaysCount Date:(NSDate *)date{
    StepsArray = [[NSMutableArray alloc]init];
//    [self searchStepsWithDays:DaysCount];
    NSDateFormatter *Upformatter = [[NSDateFormatter alloc]init];
    Upformatter.dateFormat = @"yyyy-MM-dd";
    NSLog(@"%@",date);
    
    for (int i = DaysCount-1; i>= 0; i--) {
        NSDate *day = [date dateByAddingTimeInterval:-86400*i];
        
        NSString *SearchName = [NSString stringWithFormat:@"%@Step",[Upformatter stringFromDate:day]];
        NSString *steps = [[NSUserDefaults standardUserDefaults]valueForKey:SearchName];
        NSLog(@"查询的日期%@ 步数%@",SearchName,steps);
        if (!steps) {
            steps = @"0";
        }
        [StepsArray addObject:steps];
    }
    NSLog(@"%@",StepsArray);
    
    return StepsArray;
}

-(NSMutableArray *)newStepsArrayWithDaysCount:(int)DaysCount Date:(NSDate *)date{
    StepsArray = [[NSMutableArray alloc]init];
    NSDateFormatter *Upformatter = [[NSDateFormatter alloc]init];
    Upformatter.dateFormat = @"yyyy-MM-dd";
    NSLog(@"%@",date);
    for (int i = DaysCount; i>0; i--) {
        NSDate *day = [date dateByAddingTimeInterval:-86400*i];
        
        NSString *SearchName = [NSString stringWithFormat:@"%@Step",[Upformatter stringFromDate:day]];
        
        NSString *steps = [[NSUserDefaults standardUserDefaults]valueForKey:SearchName];
        NSLog(@"查询的日期%@ 步数%@",SearchName,steps);
        if (!steps) {
            steps = @"0";
        }
        [StepsArray addObject:steps];
    }
    if( [[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"]){
            NSString *todayStep = [[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"];
            [StepsArray addObject:todayStep];
    }else{
            NSString *todayStep = @"0";
            [StepsArray addObject:todayStep];
        }
    
    return StepsArray;
}


-(void)searchStepsWithDays:(long)DayCount{
        normalFormatter = [[NSDateFormatter alloc]init];
        normalFormatter.dateFormat = @"yyyy-MM-dd";
    
        //先判断设备支不支持HealthKit
        if(![HKHealthStore isHealthDataAvailable]){
            NSLog(@"不支持HealthKit");
        }
        //创建HealthStore对象
        self.LLPunchHealthStore = [[HKHealthStore alloc]init];
        //设置需要获取的权限 如果想用其他数据可以写别的type
        HKObjectType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        NSSet *healthSet = [NSSet setWithObjects:stepType,nil];
        //用一个block来实现权限的获取
        [self.LLPunchHealthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
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

                for (int i = (int)DayCount; i >= 1; i--) {
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
        NSString *StepsCount = [NSString stringWithFormat:@"%d",count];
        NSString *SaveNameString = [NSString stringWithFormat:@"%@Step",[normalFormatter stringFromDate:oldDate]];
//        NSLog(@"步数存储的key%@",SaveNameString);
        
        [[NSUserDefaults standardUserDefaults]setObject:StepsCount forKey:SaveNameString];
//        if ([[NSUserDefaults standardUserDefaults]valueForKey:@"StepsCountArray"]) {
//            NSMutableArray *tempArray = [[NSUserDefaults standardUserDefaults]valueForKey:@"StepsCountArray"];
//            NSLog(@"tempArray%@",tempArray);
//            [tempArray insertObject:StepsCount atIndex:tempArray.count];
//            NSLog(@"tempArray%@",tempArray);
//            [[NSUserDefaults standardUserDefaults]setObject:tempArray forKey:@"StepsCountArray"];
//            NSLog(@"数据库中的步数数组是%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"StepsCountArray"]);
//        }else{
//            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
//            [tempArray addObject:StepsCount];
//            [[NSUserDefaults standardUserDefaults]setObject:tempArray forKey:@"StepsCountArray"];
            NSLog(@"%@步数%@",SaveNameString,[[NSUserDefaults standardUserDefaults]valueForKey:SaveNameString]);
//        }

        

    }];
    [self.LLPunchHealthStore executeQuery:sampleQuery];

}


@end
