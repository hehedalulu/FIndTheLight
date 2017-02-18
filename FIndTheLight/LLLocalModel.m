//
//  LLLocalModel.m
//  FIndTheLight
//
//  Created by Wll on 17/2/15.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLLocalModel.h"

@implementation LLLocalModel

-(void)RandomSetNewModel{
//    [self initLocalNameString];
//    [self initLocalLevelImage];
//    [self initLocalModelImage];
}


-(NSString *)SetLocalNameString{
    _LLLocalModelNameString = @"灯泡";
    return _LLLocalModelNameString;
}

-(NSString *)SetLocalLightValue{
    _LLLocalLightValueString = @"10";
    return _LLLocalLightValueString;
}

-(UIImage *)SetLocalModelImage{
    _LLLocalModelmage = [UIImage imageNamed:@"optical_lamp.png"];
    return _LLLocalModelmage;
}

-(UIImage *)SetLocalLevelImage{
    _LLLocalModelLevelImage = [UIImage imageNamed:@"optical_rank.png"];
    return _LLLocalModelLevelImage;
}



@end
