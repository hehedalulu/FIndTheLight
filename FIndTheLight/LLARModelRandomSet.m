//
//  LLARModelRandomSet.m
//  FIndTheLight
//
//  Created by Wll on 17/3/8.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLARModelRandomSet.h"
#import "LLFilter.h"
@implementation LLARModelRandomSet

-(LLARModel *)LLARRandomSetModel{
    //随机生成模型
    LLARModel *model = [[LLARModel alloc]init];
    int possible = arc4random() % 101;
    if (possible >= 0 && possible <= 50) {
        model.LLARModelName = @"pumpkin";
        model.LLARLightValueString = @"100";
        model.LLARModelImageName = @"pumpkin.png";
        model.LLARModelLevelImageName = @"optical_rank.png";
    }else{
        model.LLARModelName = @"star";
        model.LLARLightValueString = @"500";
        model.LLARModelImageName = @"starstar.png";
        model.LLARModelLevelImageName = @"optical_rank.png";
    }
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        //存储数据
        [realm  addObject:model];
        //写入数据库
        [realm commitWriteTransaction];
    }];
    return model;
}


-(LLSuiPian*)LLARRandomSetSuiPianWithModelName:(NSString*)ModelName{
    __block LLSuiPian *SuiPianmodel = [[LLSuiPian alloc]init];
    int possible = arc4random() % 101;
    if ([ModelName isEqualToString:@"pumpkin"]) {
        if (possible >= 0 && possible <= 30) {
            SuiPianmodel.LLSuiPianName = @"Tengman";
            SuiPianmodel.LLSuiPianPicName = @"tengman.png";
        }else if(possible >= 30 && possible <= 40){
            SuiPianmodel.LLSuiPianName = @"jianjiao";
            SuiPianmodel.LLSuiPianPicName = @"jianjiao.png";
        }else{
            SuiPianmodel.LLSuiPianName = @"nanguabing";
            SuiPianmodel.LLSuiPianPicName = @"nanguabing.png";
        }
    }else if([ModelName isEqualToString:@"star"]){
        if(possible >= 0 && possible <= 80){
            SuiPianmodel.LLSuiPianName = @"chibang";
            SuiPianmodel.LLSuiPianPicName = @"chibang.png";
        }else{
            SuiPianmodel.LLSuiPianName = @"faguangTail";
            SuiPianmodel.LLSuiPianPicName = @"faguangTail.png";
        }
    }
    
    
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *SuiPianArray = [LLSuiPian allObjectsInRealm:[RLMRealm defaultRealm]];
    RLMResults *FilterArray = [LLFilter allObjectsInRealm:[RLMRealm defaultRealm]];
    [realm transactionWithBlock:^{
        for (LLSuiPian  *suipian  in SuiPianArray) {
            if ([suipian.LLSuiPianName isEqualToString:SuiPianmodel.LLSuiPianName]) {
                suipian.LLSuiPianCount++;
                if (!suipian.SuiPianHasShow) {
                    suipian.SuiPianHasShow = YES;
                    SuiPianmodel = suipian;
//                    [self doSomeSuiPianChange:suipian];
                }
            }
        }
        
        for (LLFilter  *filter  in FilterArray) {
            if ([filter.suiPian1 isEqualToObject:SuiPianmodel]||[filter.suiPian2 isEqualToObject:SuiPianmodel]||[filter.suiPian3 isEqualToObject:SuiPianmodel]) {
                if(!filter.LLFilterHasbeenFound){
                    filter.LLFilterHasbeenFound = YES;
                }
            }
        }
        
        [realm commitWriteTransaction];
    }];
    return SuiPianmodel;
}

//-(void)doSomeSuiPianChange:(LLSuiPian*)SuiPianmodel{
//        //遍历滤镜
//        //滤镜的进度增加
//        //出现新的滤镜 滤镜开启
//        RLMRealm *realm = [RLMRealm defaultRealm];
//        RLMResults *FilterArray = [LLFilter allObjectsInRealm:[RLMRealm defaultRealm]];
//        [realm transactionWithBlock:^{
//            for (LLFilter  *filter  in FilterArray) {
//                if ([filter.suiPian1 isEqualToObject:SuiPianmodel]||[filter.suiPian2 isEqualToObject:SuiPianmodel]||[filter.suiPian3 isEqualToObject:SuiPianmodel]) {
//                    if(!filter.LLFilterHasbeenFound){
//                        filter.LLFilterHasbeenFound = YES;
//                    }
//                }
//            }
//            [realm commitWriteTransaction];
//        }];
//}


-(int)JudgeLightValue{
    int hour = 5;
    
    if (hour>=6&&hour<=7) {
        
    }else if (hour>7&&hour<=8){
    }else if (hour>8&&hour<=10){
    }else if (hour>10&&hour<=12){
    }else if (hour>12&&hour<=13){
    }else if (hour>13&&hour<=14){
    }else if (hour>14&&hour<=16){
    }else if (hour>16&&hour<=18){
    }else if (hour>18&&hour<=20){
    }else if (hour>20&&hour<=21){
    }else if (hour>21&&hour<=22){
    }else if (hour>22&&hour<=23){
    }else if (hour>23){
    }else if (hour>=0&&hour<=6){
    }
    return 0 ;
}


/***
 图书馆
 6-7    10
 7-8    8
 8-10   5
 10-12  3
 12-18  2
 18-20  3
 20-21  5
 21-22  8
 22-24  10
 0-6    2
 
 ***/

-(BOOL)isBetwennFrom:(int)from To:(int)to{
    NSDate *fromHour = [self getCustomDateWithHour:from];
    NSDate *toHour = [self getCustomDateWithHour:to];
    BOOL isBetween = [self isBetweenFromHour:fromHour toHour:toHour];
    
    return isBetween;
}


- (BOOL)isBetweenFromHour:(NSDate*)fromHour toHour:(NSDate*)toHour
{
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:fromHour]==NSOrderedDescending && [currentDate compare:toHour]==NSOrderedAscending)
    {
//        NSLog(@"该时间在 %ld:00-%ld:00 之间！",(long)fromHour,(long)toHour);
        return YES;
    }
    return NO;
}


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
