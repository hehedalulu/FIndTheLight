//
//  LLModelView.m
//  FIndTheLight
//
//  Created by Wll on 17/2/13.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLModelView.h"
#import "LLLocalModelRandomSet.h"
#import "LLARModelRandomSet.h"
#import <POP/POP.h>
@implementation LLModelView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //生成模型
    
    
    
    _LLLocalModel = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                                 [UIScreen mainScreen].bounds.size.width/2, 0, 0)];
    
    
    _LLLocalModelLevel = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                                      [UIScreen mainScreen].bounds.size.width/2, 0, 0)];

    
    
    _LLLocalName = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width/2, 0, 0)];
    _LLLocalName.font = [UIFont systemFontOfSize:18];
    _LLLocalName.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    
    
    _LLLocalWaitingBall = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.4,
                                                                       [UIScreen mainScreen].bounds.size.width*0.6, 30, 30)];
    _LLLocalWaitingBall.image = [UIImage imageNamed:@"optical_lightball.png"];
    _LLLocalWaitingBall.hidden = YES;
    
    
    _LLLocalLightValue = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.40,
                                                                 [UIScreen mainScreen].bounds.size.width*0.6,
                                                                  80, 20)];
    _LLLocalLightValue.textAlignment = NSTextAlignmentCenter;
    _LLLocalLightValue.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    _LLLocalLightValue.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:17];
//    [_LLLocalLightValue sizeToFit];
    _LLLocalLightValue.hidden = YES;
    
    
    if (self.modelViewType == 0) {//本地光体
        LLLocalModelRandomSet *randomSet = [[LLLocalModelRandomSet alloc]init];
        localmodel = [randomSet LLLoacalRandomSetModel];
        UIImage *inputimage = [UIImage imageNamed:localmodel.LLLocalModelmageName];
        _LLLocalModel.image = inputimage;
        
        UIImage *inputimage2 = [UIImage imageNamed:localmodel.LLLocalModelLevelImageName];
        _LLLocalModelLevel.image = inputimage2;
        
        _LLLocalName.text =  localmodel.LLLocalModelNameString;
        _LLLocalLightValue.text = localmodel.LLLocalLightValueString;
        
    }else if(self.modelViewType == 1){
        LLARModelRandomSet *randomSet = [[LLARModelRandomSet alloc]init];
        arModel = [randomSet LLARRandomSetModel];
        UIImage *inputimage = [UIImage imageNamed:arModel.LLARModelImageName];
        _LLLocalModel.image = inputimage;
        
        UIImage *inputimage2 = [UIImage imageNamed:arModel.LLARModelLevelImageName];
        _LLLocalModelLevel.image = inputimage2;
        
        _LLLocalName.text =  arModel.LLARModelName;
        NSLog(@"测试模型%@",_LLLocalName.text);
        _LLLocalLightValue.text = arModel.LLARLightValueString;
        
        
    }
    
    [self addSubview:_LLLocalModel];
    [self addSubview:_LLLocalModelLevel];
    [self addSubview:_LLLocalName];
    [self addSubview:_LLLocalWaitingBall];
    [self addSubview:_LLLocalLightValue];
    
}



@end
