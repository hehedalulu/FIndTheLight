//
//  LLmeasureCountTimer.h
//  FIndTheLight
//
//  Created by Wll on 16/12/15.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLmeasureCountTimer : NSObject{
    NSTimer *LLTimeCount;
}
@property int LLMatureMinute;
@property int LLMatureSecond;

-(void)TimeCount;
@end
