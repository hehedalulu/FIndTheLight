//
//  LLBoostView.m
//  FIndTheLight
//
//  Created by Wll on 16/12/21.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLBoostView.h"
#import "LLGetStep.h"
@implementation LLBoostView


- (void)drawRect:(CGRect)rect {
    _LLMatureNeedEnergy = 3600;
//    _LLNowEnergy = 2000;
   
    
    
    _LLBoostcontentView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 0, 0)];
    [_LLBoostcontentView.layer setCornerRadius:10];
    _LLBoostcontentView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_LLBoostcontentView];
    
    [self DrawinNeed];
}

-(void)DrawinNeed{
//    LLGetStep *getstep = [[LLGetStep alloc]init];
//    [getstep CreatHealth];
    
//    NSString *nowEnergy = [[NSUserDefaults standardUserDefaults]valueForKey:@"energy"];
//    _LLNowEnergy = [nowEnergy intValue];
//    NSLog(@"拿到的能量值是%d",_LLNowEnergy);
    
    
    _LLTapBoostbtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 130, 0, 0)];
    _LLTapBoostbtn.titleLabel.textColor = [UIColor blackColor];
    [_LLTapBoostbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _LLTapBoostbtn.backgroundColor = [UIColor orangeColor];
    _LLTapBoostbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_LLBoostcontentView addSubview:_LLTapBoostbtn];
    
    _LLBoostContextLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 0, 0)];
    _LLBoostContextLabel.font = [UIFont systemFontOfSize:13];
    _LLBoostContextLabel.textColor = [UIColor blackColor];
    _LLBoostContextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //    _LLBoostContextLabel.backgroundColor = [UIColor whiteColor];
    [_LLBoostcontentView addSubview: _LLBoostContextLabel];
    
    if (_LLNowEnergy == 0) {
        NSString *ContextString = @"没有能量 快出门走走补充能量";
        _LLBoostContextLabel.text = ContextString;
        _LLTapBoostbtn.titleLabel.text = @"好的";
        NSLog(@"当前用户没有能量");
    }else if(_LLNowEnergy <=_LLMatureNeedEnergy ){
        NSString *ContextString = [NSString stringWithFormat:@"需使用%ld能量完成收集",_LLMatureNeedEnergy];
        _LLBoostContextLabel.text = ContextString;
        
        [_LLTapBoostbtn setTitle:[NSString stringWithFormat:@"使用%d能量加速",_LLNowEnergy] forState:UIControlStateNormal];
        NSLog(@"当前用户能量不够，该用户现有的能量是%d,加速全部完成所需的能量是%ld",_LLNowEnergy,_LLMatureNeedEnergy);
    }else{
        NSString *ContextString = [NSString stringWithFormat:@"使用%ld能量完成收集",_LLMatureNeedEnergy];
        _LLBoostContextLabel.text = ContextString;
        _LLTapBoostbtn.titleLabel.text = @"立即加速";
        NSLog(@"当前用户能量足够或超出");
    }

}
@end
