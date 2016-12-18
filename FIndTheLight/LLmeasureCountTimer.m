//
//  LLmeasureCountTimer.m
//  FIndTheLight
//
//  Created by Wll on 16/12/15.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLmeasureCountTimer.h"

@implementation LLmeasureCountTimer

-(void)TimeCount{
    _LLMatureMinute = 0;
    _LLMatureSecond = 0;
    LLTimeCount = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(StartCount:) userInfo:nil repeats:YES];
    [LLTimeCount fire];
}



-(void)StartCount:(NSTimer *)timer{
    if (_LLMatureSecond == 60) {
        _LLMatureSecond = 0;
        _LLMatureMinute++;
        _LLMatureSecond++;
//        NSLog(@"%d:%d",_LLMatureMinute,_LLMatureSecond);
        if (_LLMatureMinute == 5) {
            [LLTimeCount invalidate];
        }
    }else{
        _LLMatureSecond++;
//        NSLog(@"%d:%d",_LLMatureMinute,_LLMatureSecond);
    }
}
@end
