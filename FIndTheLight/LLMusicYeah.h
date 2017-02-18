//
//  LLMusicYeah.h
//  FIndTheLight
//
//  Created by Wll on 17/2/16.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface LLMusicYeah : NSObject{
    SystemSoundID ClickWaitingBall;
}
-(void)playSound:(NSString*)name type:(NSString*)type;
@end
