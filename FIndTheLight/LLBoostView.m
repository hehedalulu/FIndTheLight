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
/*
 llBoostView.LLTapBoostbtn.frame = CGRectMake(30, 130, 150, 40);
 llBoostView.LLBoostContextLabel.frame = CGRectMake(10, 10, 180, 100);
 llBoostView.LLBoostcontentView.frame = CGRectMake(100, 200, 200, 200);
 */

-(void)drawRect:(CGRect)rect {
    
}

-(void)DrawinNeed{

    _LLBoostcontentView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, 0, 0)];
    _LLBoostcontentView.image = [UIImage imageNamed:@"layer.png"];
    _LLBoostcontentView.clipsToBounds = YES;
    _LLBoostcontentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_LLBoostcontentView];
    
    _LLTapBoostbtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.19, 0, 0)];
    UIImageView *tapbtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                          [UIScreen mainScreen].bounds.size.width*0.3623,
                                                                          [UIScreen mainScreen].bounds.size.width*0.097)];
    tapbtnImg.image = [UIImage imageNamed:@"btn_confirm.png"];
    tapbtnImg.clipsToBounds = YES;
    [_LLTapBoostbtn addSubview:tapbtnImg];
    _LLTapBoostbtn.titleLabel.textColor = [UIColor blackColor];
    [_LLTapBoostbtn setTitleColor:[UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1] forState:UIControlStateNormal];
    _LLTapBoostbtn.clipsToBounds = YES;
    _LLTapBoostbtn.userInteractionEnabled = YES;
    _LLTapBoostbtn.titleLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:15];;
    [_LLBoostcontentView addSubview:_LLTapBoostbtn];

    
    _LLBoostContextLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.073, 0, 0, 0)];
    _LLBoostContextLabel.textAlignment = NSTextAlignmentCenter;
    _LLBoostContextLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:17];
    _LLBoostContextLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    _LLBoostContextLabel.clipsToBounds = YES;
    _LLBoostContextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //    _LLBoostContextLabel.backgroundColor = [UIColor whiteColor];
    [_LLBoostcontentView addSubview: _LLBoostContextLabel];
    
    if (_LLNowEnergy <= 0) {
        NSString *ContextString = @"没有能量 快出门走走补充能量";
        _LLBoostContextLabel.text = ContextString;
        _LLTapBoostbtn.titleLabel.text = @"好的";
        [_LLTapBoostbtn setTitle:@"好的" forState:UIControlStateNormal];
        NSLog(@"当前用户没有能量");
    }else if(_LLNowEnergy <= _LLMatureNeedEnergy ){
        NSString *ContextString = [NSString stringWithFormat:@"需使用%ld能量完成收集",_LLMatureNeedEnergy];
        _LLBoostContextLabel.text = ContextString;
        
        [_LLTapBoostbtn setTitle:[NSString stringWithFormat:@"使用%d能量加速",_LLNowEnergy] forState:UIControlStateNormal];
        NSLog(@"当前用户能量不够，该用户现有的能量是%d,加速全部完成所需的能量是%ld",_LLNowEnergy,_LLMatureNeedEnergy);
    }else{
        NSString *ContextString = [NSString stringWithFormat:@"使用%ld能量完成收集",_LLMatureNeedEnergy];
        _LLBoostContextLabel.text = ContextString;
        [_LLTapBoostbtn setTitle:@"立即加速" forState:UIControlStateNormal];
        NSLog(@"当前用户能量足够或超出");
    }

}

@end
