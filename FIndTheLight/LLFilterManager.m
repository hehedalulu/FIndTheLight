//
//  LLFilterManager.m
//  FIndTheLight
//
//  Created by Wll on 17/3/15.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLFilterManager.h"

@implementation LLFilterManager

-(void)SetFilterValue{
    LLFilter *filter1 = [[LLFilter alloc]init];
    filter1.LLFilterName = @"默认滤镜";
    filter1.LLFilterPicName = @"icon_filter.png";
    filter1.LLFilterLevel = @"A";
    filter1.LLFilterProgress = 0;
    filter1.LLFilterSuiPianCount = 3;
    filter1.LLFilterHasbeenFound = NO;
    filter1.LLFilterHasBeenMixed = NO;
    
    RLMResults<LLSuiPian *> *suipian1 = [LLSuiPian objectsWhere:@"LLSuiPianName == 'boli'"];
    filter1.suiPian1 = [suipian1 firstObject];
    filter1.LLsuiPian1Need = 10;
    filter1.LLsuiPian1Had = 0;
    filter1.LLsuiPian1HasFininshed = NO;
    
    RLMResults<LLSuiPian *> *suipian2 = [LLSuiPian objectsWhere:@"LLSuiPianName == 'aiyi'"];
    filter1.suiPian2 = [suipian2 firstObject];
    filter1.LLsuiPian2Need = 10;
    filter1.LLsuiPian2Had = 0;
    filter1.LLsuiPian2HasFininshed = NO;
    
//    filter1.suiPian3.LLSuiPianName = @"Tengman";
    RLMResults<LLSuiPian *> *suipian3 = [LLSuiPian objectsWhere:@"LLSuiPianName == 'Tengman'"];
    filter1.suiPian3 = [suipian3 firstObject];
    filter1.LLsuiPian3Need = 10;
    filter1.LLsuiPian3Had = 0;
    filter1.LLsuiPian3HasFininshed = NO;
    
    LLFilter *filter2 = [[LLFilter alloc]init];
    filter2.LLFilterName = @"樱花雨";
    filter2.LLFilterPicName = @"icon_filter.png";
    filter2.LLFilterLevel = @"S";
    filter2.LLFilterProgress = 0;
    filter2.LLFilterSuiPianCount = 3;
    filter2.LLFilterHasbeenFound = NO;
    filter2.LLFilterHasBeenMixed = NO;
    
//    filter2.suiPian1.LLSuiPianName = @"jianjiao";
    RLMResults<LLSuiPian *> *suipian4 = [LLSuiPian objectsWhere:@"LLSuiPianName == 'jianjiao'"];
    filter2.suiPian1 = [suipian4 firstObject];
    filter2.LLsuiPian1Need = 10;
    filter2.LLsuiPian1Had = 0;
    filter2.LLsuiPian1HasFininshed = NO;
    
//    filter2.suiPian2.LLSuiPianName = @"chibang";
    RLMResults<LLSuiPian *> *suipian5 = [LLSuiPian objectsWhere:@"LLSuiPianName == 'chibang'"];
    filter2.suiPian2 = [suipian5 firstObject];
    filter2.LLsuiPian2Need = 10;
    filter2.LLsuiPian2Had = 0;
    filter2.LLsuiPian2HasFininshed = NO;
    
//    filter2.suiPian3.LLSuiPianName = @"faguangTail";
    RLMResults<LLSuiPian *> *suipian6 = [LLSuiPian objectsWhere:@"LLSuiPianName == 'faguangTail'"];
    filter2.suiPian3 = [suipian6 firstObject];
    filter2.LLsuiPian3Need = 10;
    filter2.LLsuiPian3Had = 0;
    filter2.LLsuiPian3HasFininshed = NO;
    
    LLFilter *filter3 = [self Backfilter];
    LLFilter *filter4 = [self Backfilter];
    LLFilter *filter5 = [self Backfilter];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        //存储数据
        [realm  addObject:filter1];
        [realm  addObject:filter2];
        [realm  addObject:filter3];
        [realm  addObject:filter4];
        [realm  addObject:filter5];
        //写入数据库
        [realm commitWriteTransaction];
    }];
    
}

-(LLFilter* )Backfilter{
    LLFilter *filter = [[LLFilter alloc]init];
    filter.LLFilterName = @"未知";
    filter.LLFilterPicName = @"icon_filter.png";
    filter.LLFilterLevel = @"?";
    filter.LLFilterProgress = 0;
    filter.LLFilterSuiPianCount = 3;
    filter.LLFilterHasbeenFound = NO;
    filter.LLFilterHasBeenMixed = NO;
    
    filter.suiPian1.LLSuiPianName = @"碎片1";
    filter.LLsuiPian1Need = 10;
    filter.LLsuiPian1Had = 0;
    filter.LLsuiPian1HasFininshed = NO;
    
    filter.suiPian2.LLSuiPianName = @"碎片2";
    filter.LLsuiPian2Need = 10;
    filter.LLsuiPian2Had = 0;
    filter.LLsuiPian2HasFininshed = NO;
    
    filter.suiPian3.LLSuiPianName = @"碎片3";
    filter.LLsuiPian3Need = 10;
    filter.LLsuiPian3Had = 0;
    filter.LLsuiPian3HasFininshed = NO;
    
    return filter;
}


@end
