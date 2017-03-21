//
//  LLCustomeSKView.h
//  FIndTheLight
//
//  Created by Wll on 17/3/18.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LLFilterScene.h"

@interface LLCustomeSKView : SKView

@property (copy)NSString *LLCustomeFilterName;
//每套滤镜有多套不同的level光量值

//每个scene有不同的TextureAtlas的名字 数量



@property NSMutableArray *LLFilterSceneArray;


@end
