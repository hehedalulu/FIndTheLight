//
//  LLModelView.m
//  FIndTheLight
//
//  Created by Wll on 17/2/13.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLModelView.h"
#import <POP/POP.h>
@implementation LLModelView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    _LLLocalModel = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width/2, 0, 0)];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"optical_lamp.png" ofType:nil];
//        UIImage *inputimage = [UIImage imageWithContentsOfFile:path];
    UIImage *inputimage = [UIImage imageNamed:@"optical_lamp.png"];
    _LLLocalModel.image = inputimage;
    [self addSubview:_LLLocalModel];
    
    _LLLocalModelLevel = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width/2, 0, 0)];
    UIImage *inputimage2 = [UIImage imageNamed:@"optical_rank.png"];
    _LLLocalModelLevel.image = inputimage2;
    [self addSubview:_LLLocalModelLevel];
    
    _LLLocalName = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width/2, 0, 0)];
    _LLLocalName.text = @"灯泡";
//    _LLLocalName.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    _LLLocalName.font = [UIFont systemFontOfSize:18];
    _LLLocalName.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [self addSubview:_LLLocalName];
    
    _LLLocalWaitingBall = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.4,
                                                                       [UIScreen mainScreen].bounds.size.width*0.6, 30, 30)];
    _LLLocalWaitingBall.image = [UIImage imageNamed:@"optical_lightball.png"];
    _LLLocalWaitingBall.hidden = YES;
    [self addSubview:_LLLocalWaitingBall];
    
    _LLLocalLightValue = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.40,
                                                                 [UIScreen mainScreen].bounds.size.width*0.6,
                                                                  80, 20)];
    _LLLocalLightValue.text = @"1000";
    _LLLocalLightValue.textAlignment = NSTextAlignmentCenter;
    _LLLocalLightValue.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    _LLLocalLightValue.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:17];
//    [_LLLocalLightValue sizeToFit];
    _LLLocalLightValue.hidden = YES;
    [self addSubview:_LLLocalLightValue];
    
}



@end
