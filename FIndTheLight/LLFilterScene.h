//
//  LLFilterScene.h
//  FIndTheLight
//
//  Created by Wll on 17/3/19.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LLFilterScene : SKScene{
    BOOL hasCreat;
    SKSpriteNode *bombNode;
}

@property (copy) NSString *LLFilterSceneAtlasName;

@property (assign) int LLFilterSceneAtlasCount;

@property (assign) int LLFilterSceneValue;




@end
