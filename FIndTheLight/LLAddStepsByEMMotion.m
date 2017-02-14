//
//  LLAddStepsByEMMotion.m
//  FIndTheLight
//
//  Created by Wll on 17/2/8.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLAddStepsByEMMotion.h"

@implementation LLAddStepsByEMMotion
-(void)PedometerGetSteps{

    // 1.判断计步器是否可用
    if (![CMPedometer isStepCountingAvailable]) {
        NSLog(@"计步器不可用");
        return;
    }
    // 2.创建计步器
    self.LLNowPedometer = [[CMPedometer alloc] init];
    // 3.开始计步
    [self.LLNowPedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            return;
        }
        NSLog(@"当前计步器记下的步数%@",pedometerData.numberOfSteps);
        if (self.ConutStep != pedometerData.numberOfSteps) {
            NSLog(@"原先的计步器记下的步数值%@",self.ConutStep);
            int temp = self.ConutStep.intValue;
            self.ConutStep = pedometerData.numberOfSteps;
            
            int addStep = self.ConutStep.intValue - temp;
            NSLog(@"增加的步数%d",addStep);
            //
            //当天步数的一个增加
            NSString *todaySteps = [[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"];
            int resultSteps = todaySteps.intValue + addStep;
            NSString *resultString = [NSString stringWithFormat:@"%d",resultSteps];
            [[NSUserDefaults standardUserDefaults]setValue:resultString forKey:@"NowDayEnergy"];
            NSLog(@"当天走下的步数%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"]);
            //当天能量的一个增加
            NSString *energy = [[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"];
            int resultEnergy = energy.intValue + addStep;
            NSString *resultEnergyString = [NSString stringWithFormat:@"%d",resultEnergy];
            [[NSUserDefaults standardUserDefaults]setValue:resultEnergyString forKey:@"Energy"];
            NSLog(@"当前能量%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"]);
            
        }
    }];

}

@end
