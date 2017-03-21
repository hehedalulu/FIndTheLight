//
//  LLFIlterSceneManager.h
//  FIndTheLight
//
//  Created by Wll on 17/3/18.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLCustomeSKView.h"

#import "FilterDefaultRain.h"
#import "FilterDefaultCloud.h"
#import "FilterDefaultSunshine.h"

@interface LLFIlterSceneManager : NSObject{
//    LLCustomeSKView *skView;
//    SKScene *rightScene;
    NSMutableArray *ValueLevelArray;
    LLFilterScene *rightScene;
    LLFilterScene *NextScene;
}
@property (assign) double LLSKViewLightValue;
@property (nonatomic) LLCustomeSKView *skView;
//@property (assign) double LLSKViewChangeValue;

//初始化skview
-(LLCustomeSKView *)setSKView;
//初始化滤镜
-(void)setFilter;
//设置初始化的滤镜背景
-(LLFilterScene *)ComfirmLevelValueBackScene;
//改变滤镜进度
-(LLFilterScene *)ChangeSKViewWithChangeValue:(double)changeValue;
//切换滤镜
-(void)ChangeFilterwithNewFilter:(NSString *)FilterName;

@end
