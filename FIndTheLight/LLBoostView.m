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

- (void)drawRect:(CGRect)rect {

    
//    [self DrawinNeed];
}

-(void)DrawinNeed{
//    LLGetStep *getstep = [[LLGetStep alloc]init];
//    [getstep CreatHealth];
    
//    NSString *nowEnergy = [[NSUserDefaults standardUserDefaults]valueForKey:@"energy"];
//    _LLNowEnergy = [nowEnergy intValue];
//    NSLog(@"拿到的能量值是%d",_LLNowEnergy);
//    _LLMatureNeedEnergy = 3600;
    //    _LLNowEnergy =
    _LLBoostcontentView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, 0, 0)];
    _LLBoostcontentView.image = [UIImage imageNamed:@"layer.png"];
    _LLBoostcontentView.clipsToBounds = YES;
    _LLBoostcontentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_LLBoostcontentView];
    
    _LLTapBoostbtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 70, 0, 0)];
    _LLTapBoostbtn.titleLabel.textColor = [UIColor blackColor];
    [_LLTapBoostbtn setTitleColor:[UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1] forState:UIControlStateNormal];
    _LLTapBoostbtn.backgroundColor = [UIColor orangeColor];
    _LLTapBoostbtn.clipsToBounds = YES;
    _LLTapBoostbtn.userInteractionEnabled = YES;
    _LLTapBoostbtn.titleLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:15];;
    [_LLBoostcontentView addSubview:_LLTapBoostbtn];
    [_LLTapBoostbtn addTarget:self action:@selector(dayin) forControlEvents:UIControlEventTouchUpInside];
    
    _LLBoostContextLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 0, 0)];
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

-(void)dayin{
    NSLog(@"点击了");

    NSString *currentEnergyString = [[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"];
    int currentEnergy = [currentEnergyString intValue];
    //能量减少 时间减少

    
}
@end
