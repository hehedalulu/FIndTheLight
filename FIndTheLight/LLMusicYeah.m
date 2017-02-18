//
//  LLMusicYeah.m
//  FIndTheLight
//
//  Created by Wll on 17/2/16.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLMusicYeah.h"


@implementation LLMusicYeah

- (void)playSound:(NSString*)name type:(NSString*)type{
    
    //得到音效文件的地址
    
    NSString*soundFilePath =[[NSBundle mainBundle] pathForResource:name ofType:type];
    
    //将地址字符串转换成url
    
    NSURL*soundURL = [NSURL fileURLWithPath:soundFilePath];
    
    //生成系统音效id
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &ClickWaitingBall);
    
    //播放系统音效
    
    AudioServicesPlaySystemSound(ClickWaitingBall);
    
}
@end
