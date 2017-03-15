//
//  LLLocalModelRandomSet.m
//  FIndTheLight
//
//  Created by Wll on 17/3/8.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLLocalModelRandomSet.h"


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
    return model;
}


-(LLLocalSuiPian*)LLLocalRandomSetSuiPianWithModelName:(NSString*)ModelName{
    LLLocalSuiPian *SuiPianmodel = [[LLLocalSuiPian alloc]init];
    int possible = arc4random() % 101;
    if ([ModelName isEqualToString:@"dengpao"]) {
        if (possible >= 0 && possible <= 10) {
            SuiPianmodel.LLLocalSuiPianNameString = @"naiqi";
            SuiPianmodel.LLLocalSuiPianImageName = @"naiqi.png";
        }else if(possible >= 10 && possible <= 70){
            SuiPianmodel.LLLocalSuiPianNameString = @"boli";
            SuiPianmodel.LLLocalSuiPianImageName = @"boli.png";
        }else{
            SuiPianmodel.LLLocalSuiPianNameString = @"wusi";
            SuiPianmodel.LLLocalSuiPianImageName = @"wusi.png";
        }
    }else if([ModelName isEqualToString:@"zuanshi"]){
        if(possible >= 0 && possible <= 30){
            SuiPianmodel.LLLocalSuiPianNameString = @"aiyi";
            SuiPianmodel.LLLocalSuiPianImageName = @"aiyi.png";
        }else{
            SuiPianmodel.LLLocalSuiPianNameString = @"jingti";
            SuiPianmodel.LLLocalSuiPianImageName = @"jingti.png";
        }
    }

    return SuiPianmodel;
}

@end
