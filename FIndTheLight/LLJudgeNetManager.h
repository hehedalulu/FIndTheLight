//
//  LLJudgeNetManager.h
//  FIndTheLight
//
//  Created by Wll on 17/3/4.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLJudgeNetManager : NSObject
//注册检测网络的通知
-(void)registNetChange;
//判断当前网络状态
-(void)JudgeNowNetwork;

@end
