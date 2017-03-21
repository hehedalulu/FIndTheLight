//
//  LLLocalModelRandomSet.m
//  FIndTheLight
//
//  Created by Wll on 17/3/8.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLLocalModelRandomSet.h"
#import "LLFilter.h"

@implementation LLLocalModelRandomSet

-(LLLocalModel *)LLLoacalRandomSetModel{
    //随机生成模型
    LLLocalModel *model = [[LLLocalModel alloc]init];
    int possible = arc4random() % 101;
    if (possible >= 0 && possible <= 50) {
        model.LLLocalModelNameString = @"zuanshi";
        model.LLLocalLightValueString = @"10";
        model.LLLocalModelmageName = @"zuanshi.png";
        model.LLLocalModelLevelImageName = @"optical_rank.png";
    }else{
        model.LLLocalModelNameString = @"dengpao";
        model.LLLocalLightValueString = @"15";
        model.LLLocalModelmageName = @"optical_lamp.png";
        model.LLLocalModelLevelImageName = @"optical_rank.png";
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


-(LLSuiPian*)LLLocalRandomSetSuiPianWithModelName:(NSString*)ModelName{
    __block LLSuiPian *SuiPianmodel = [[LLSuiPian alloc]init];
    int possible = arc4random() % 101;
    if ([ModelName isEqualToString:@"dengpao"]) {
        if (possible >= 0 && possible <= 10) {
            SuiPianmodel.LLSuiPianName = @"naiqi";
            SuiPianmodel.LLSuiPianPicName = @"naiqi.png";
        }else if(possible >= 10 && possible <= 70){
            SuiPianmodel.LLSuiPianName = @"boli";
            SuiPianmodel.LLSuiPianPicName = @"boli.png";
        }else{
            SuiPianmodel.LLSuiPianName = @"wusi";
            SuiPianmodel.LLSuiPianPicName = @"wusi.png";
        }
    }else if([ModelName isEqualToString:@"zuanshi"]){
        if(possible >= 0 && possible <= 30){
            SuiPianmodel.LLSuiPianName = @"aiyi";
            SuiPianmodel.LLSuiPianPicName = @"aiyi.png";
        }else{
            SuiPianmodel.LLSuiPianName = @"jingti";
            SuiPianmodel.LLSuiPianPicName = @"jingti.png";
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
//                     [self doSomeSuiPianChange:suipian];
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
/*
-(void)doSomeSuiPianChange:(LLSuiPian*)SuiPianmodel{
    //遍历滤镜
    //滤镜的进度增加
    //出现新的滤镜 滤镜开启
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *FilterArray = [LLFilter allObjectsInRealm:[RLMRealm defaultRealm]];
    [realm transactionWithBlock:^{
        for (LLFilter  *filter  in FilterArray) {
            if ([filter.suiPian1 isEqualToObject:SuiPianmodel]||[filter.suiPian2 isEqualToObject:SuiPianmodel]||[filter.suiPian3 isEqualToObject:SuiPianmodel]) {
                if(!filter.LLFilterHasbeenFound){
                    filter.LLFilterHasbeenFound = YES;
                }
            }
        }
        [realm commitWriteTransaction];
    }];
}
*/
@end
