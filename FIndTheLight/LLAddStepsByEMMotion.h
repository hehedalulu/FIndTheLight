//
//  LLAddStepsByEMMotion.h
//  FIndTheLight
//
//  Created by Wll on 17/2/8.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface LLAddStepsByEMMotion : NSObject{
    
}
@property (strong,nonatomic) CMPedometer *LLNowPedometer;
@property (strong) NSNumber *ConutStep;
-(void)PedometerGetSteps;
@end
