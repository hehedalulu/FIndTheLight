//
//  LLTimerLabel.h
//  FIndTheLight
//
//  Created by Wll on 16/12/14.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLTimerLabel : UILabel
{
    int LLcountSeconds;
    NSTimer *countTimer;
    NSString *ClockTime;
}
@property int  LLtimerminute;
@property int  LLtimersecond;
-(void)setCountDown;
@end
