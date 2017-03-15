//
//  LLStepsManger.h
//  FIndTheLight
//
//  Created by Wll on 17/3/11.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import "LLEveryDaystep.h"

@interface LLStepsManger : NSObject{
    NSDateFormatter *StepWeekFormatter;
    NSDateFormatter *StepDayFormatter;
    NSDateFormatter *StepDateFormatter;
    HKHealthStore *LLStepHealthStore;
    RLMRealm *StepHealthRealm;
    NSMutableArray *StepWeekArray;
    
}

-(void)initLLStepsModel;

@end
