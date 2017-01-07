//
//  LLGetStep.h
//  FIndTheLight
//
//  Created by Wll on 16/12/5.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface LLGetStep : NSObject

@property(nonatomic,strong) HKHealthStore *HealthStore;
@property(nonatomic) int LLUserStep;

-(void)FirstCreatHealth;
-(void)CreatAddHealth;
@end
