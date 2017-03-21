//
//  LLFilterScene.m
//  FIndTheLight
//
//  Created by Wll on 17/3/19.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLFilterScene.h"

@implementation LLFilterScene
@synthesize LLFilterSceneAtlasName;
@synthesize LLFilterSceneAtlasCount;


- (void)didMoveToView:(SKView *)view {
    
//    if (!hasCreat) {
    self.backgroundColor = [SKColor clearColor];
    [self CreatSceneContent];
//        hasCreat = YES;
//    }
}


-(void)CreatSceneContent{
    
    SKTextureAtlas *iOSTextureAtlas = [SKTextureAtlas atlasNamed:LLFilterSceneAtlasName];
    
    NSMutableArray *allTextureArray = [NSMutableArray arrayWithCapacity:LLFilterSceneAtlasCount];
    
    for (int i = 1; i < iOSTextureAtlas.textureNames.count+1; i++) {
        
        NSString *textureName = [NSString stringWithFormat:@"%@_%d.png",LLFilterSceneAtlasName,i];

        SKTexture *texture = [iOSTextureAtlas textureNamed:textureName];
        
        [allTextureArray addObject:texture];
        
    }
    
    bombNode = [SKSpriteNode spriteNodeWithTexture:allTextureArray[0]];
    
    bombNode.position = CGPointMake(self.size.width/2, self.size.height/2);
    
    bombNode.size = CGSizeMake(self.size.width, self.size.height);
    
    bombNode.anchorPoint = CGPointMake(0.5, 0.5);
    
    [self addChild:bombNode];
    
    //效果动画
    SKAction *animationAction = [SKAction animateWithTextures:allTextureArray timePerFrame:0.03];
//    SKAction *actionWait = [SKAction waitForDuration:2.0];
    
    //repeatActionForever这个动作的效果是让动画重复执行.
//    [bombNode runAction: [SKAction repeatActionForever:[SKAction sequence:@[animationAction,actionWait]]]];
    [bombNode runAction:[SKAction repeatActionForever:animationAction]];

}

-(void)willMoveFromView:(SKView *)view{
    [bombNode removeFromParent];
}



@end
