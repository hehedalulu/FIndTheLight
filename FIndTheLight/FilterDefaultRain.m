//
//  FilterDefaultRain.m
//  FIndTheLight
//
//  Created by Wll on 17/2/5.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "FilterDefaultRain.h"

@implementation FilterDefaultRain
- (void)didMoveToView:(SKView *)view {
    
    if (!hasCreatRain) {
        [self CreatSceneContent];
        hasCreatRain = YES;
    }
    
}

-(void)CreatSceneContent{
    
    NSString *rainPath = [[NSBundle mainBundle]pathForResource:@"MyParticle" ofType:@"sks"];
    
    rain = [NSKeyedUnarchiver unarchiveObjectWithFile:rainPath];
    
    rain.position = CGPointMake(212, 368);
    
    rain.particleColor = [SKColor whiteColor];
    [self addChild:rain];
    
    self.backgroundColor = [SKColor clearColor];
    
    
    
    SKTextureAtlas *iOSTextureAtlas = [SKTextureAtlas atlasNamed:@"filter_lightening"];
    
    NSMutableArray *allTextureArray = [NSMutableArray arrayWithCapacity:50];
    
    for (int i = 1; i < iOSTextureAtlas.textureNames.count+1; i++) {
        
        NSString *textureName = [NSString stringWithFormat:@"FilterLighting_%d.png",i];
        
        SKTexture *texture = [iOSTextureAtlas textureNamed:textureName];
        
        [allTextureArray addObject:texture];
        
    }
    
    SKSpriteNode *bombNode = [SKSpriteNode spriteNodeWithTexture:allTextureArray[0]];
    
    bombNode.position = CGPointMake(self.size.width/2, self.size.height/2);
    
    bombNode.size = CGSizeMake(self.size.width, self.size.height);
    
    bombNode.anchorPoint = CGPointMake(0.5, 0.5);
    
    [self addChild:bombNode];
    
    //爆炸效果动画
    SKAction *animationAction = [SKAction animateWithTextures:allTextureArray timePerFrame:0.03];
    SKAction *actionWait = [SKAction waitForDuration:2.0];
    
    //repeatActionForever这个动作的效果是让动画重复执行.
    [bombNode runAction: [SKAction repeatActionForever:[SKAction sequence:@[animationAction,actionWait]]]];
    
}

-(void)update:(NSTimeInterval)currentTime{
    
    rain.particleBirthRate = _Filter_rainNumber;
    
}

@end
