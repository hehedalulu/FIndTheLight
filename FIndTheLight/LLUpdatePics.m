//
//  LLUpdatePics.m
//  FIndTheLight
//
//  Created by Wll on 17/3/7.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLUpdatePics.h"
#import "RandomSetARPics.h"
#import "LLARPicsModel.h"

@implementation LLUpdatePics
-(void)LLupdateARPics{
    //判断时间区间
    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"AMFirstOpen"]&&![[NSUserDefaults standardUserDefaults]valueForKey:@"PMFirstOpen"]) {//第一次打开应用
        if ([self isBetweenFromHour:6 toHour:18]) {//第一次在6-18点打开
            [[NSUserDefaults standardUserDefaults]setValue:@"Yes" forKey:@"AMFirstOpen"];
            [[NSUserDefaults standardUserDefaults]setValue:@"No" forKey:@"PMFirstOpen"];
            NSLog(@"第一次6-18点打开");
        }else{
            [[NSUserDefaults standardUserDefaults]setValue:@"No" forKey:@"AMFirstOpen"];
            [[NSUserDefaults standardUserDefaults]setValue:@"Yes" forKey:@"PMFirstOpen"];
            NSLog(@"第一次18点之后货6点之前打开");
        }
    }
    //不是第一次打开
        if ([self isBetweenFromHour:6 toHour:18]) {//6-18点打开
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"AMFirstOpen"] isEqualToString:@"Yes"]) {
                //第一次打开更新
                
                //全删掉
                RLMRealm * rlmRealm = [RLMRealm defaultRealm];
                [rlmRealm beginWriteTransaction];
                RLMResults<LLARPicsModel *> *model = [LLARPicsModel allObjects];
                [rlmRealm deleteObjects:model];
                [rlmRealm commitWriteTransaction];
                
                RandomSetARPics *random = [[RandomSetARPics alloc]init];
                random.AMOrPM = @"AM";
                [random SetImages];
                NSLog(@"6-18点打开,更新数据库");
                [[NSUserDefaults standardUserDefaults]setValue:@"No" forKey:@"AMFirstOpen"];
                [[NSUserDefaults standardUserDefaults]setValue:@"Yes" forKey:@"PMFirstOpen"];
            }else{
                //不是第一次打开不更新
                NSLog(@"6-18点非第一次打开,不更新数据库");
            }
        }else{
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"PMFirstOpen"] isEqualToString:@"Yes"]) {
                //第一次打开更新
                NSLog(@"测试");
                RLMRealm * rlmRealm = [RLMRealm defaultRealm];
                [rlmRealm beginWriteTransaction];
                RLMResults<LLARPicsModel *> *model = [LLARPicsModel allObjects];
                [rlmRealm deleteObjects:model];
                [rlmRealm commitWriteTransaction];
                
                RandomSetARPics *random = [[RandomSetARPics alloc]init];
                random.AMOrPM = @"PM";
                [random SetImages];
                NSLog(@"18点之后打开,更新数据库");
                [[NSUserDefaults standardUserDefaults]setValue:@"Yes" forKey:@"AMFirstOpen"];
                [[NSUserDefaults standardUserDefaults]setValue:@"No" forKey:@"PMFirstOpen"];
            }else{
                //不是第一次打开不更新
                 NSLog(@"18点之后非第一次打开,不更新数据库");
            }
        }

}

- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *date8 = [self getCustomDateWithHour:6];
    NSDate *date23 = [self getCustomDateWithHour:18];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date8]==NSOrderedDescending && [currentDate compare:date23]==NSOrderedAscending)
    {
        NSLog(@"该时间在 %ld:00-%ld:00 之间！",(long)fromHour,(long)toHour);
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}

@end
