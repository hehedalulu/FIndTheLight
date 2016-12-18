//
//  LLTimerLabel.m
//  FIndTheLight
//
//  Created by Wll on 16/12/14.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLTimerLabel.h"

@implementation LLTimerLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

}

//设置点击验证码后 60秒内不能够点击
-(void)setCountDown{
    self.font = [UIFont systemFontOfSize:19];
    self.textColor = [UIColor whiteColor];
    NSLog(@"计时开始");

    
    LLcountSeconds = 0;
    _LLtimerminute = 0;
    _LLtimersecond = 0;
    ClockTime = [NSString  stringWithFormat:@"%2d : %2d",_LLtimerminute,_LLtimersecond];
    self.text = ClockTime;
    countTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimeWithSeconds:) userInfo:nil repeats:YES];
    [countTimer fire];
}
//60秒之后 可以点击发送验证码
-(void)countDownTimeWithSeconds:(NSTimer*)timerInfo{
    if (_LLtimersecond == 60) {
        _LLtimersecond = 0;
        _LLtimerminute ++;
        _LLtimersecond ++;
        NSLog(@"minute%d seconds%d",_LLtimerminute,_LLtimersecond);

    } else {
        _LLtimersecond++;
        if (_LLtimerminute == 2) {
            _LLtimerminute = 0;
            _LLtimersecond = 0;
          [countTimer invalidate];
        }
        NSLog(@"minute%d seconds%d",_LLtimerminute,_LLtimersecond);
    }
}

@end
