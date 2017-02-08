//
//  FilterDefaultCloud.m
//  FIndTheLight
//
//  Created by Wll on 17/2/5.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "FilterDefaultCloud.h"

@implementation FilterDefaultCloud
- (void)didMoveToView:(SKView *)view {
    if (!hasCreatCloud) {
        [self CreatCloudScene];
        hasCreatCloud = YES;
    }
    
}

-(void)CreatCloudScene{
    self.backgroundColor = [SKColor clearColor];
    NSString *rainPath = [[NSBundle mainBundle]pathForResource:@"SmallRain" ofType:@"sks"];
    
    SKEmitterNode *rain = [NSKeyedUnarchiver unarchiveObjectWithFile:rainPath];
    rain.position = CGPointMake(212, 368);
    rain.particleColor = [SKColor whiteColor];
    [self addChild:rain];
    
//    self.backgroundColor = [SKColor darkGrayColor];
    
    
    SKSpriteNode *backcloud = [SKSpriteNode spriteNodeWithImageNamed:@"filter_cloud5.png"];
    backcloud.position = CGPointMake(207, 661);
    backcloud.size = CGSizeMake(414, 150);
    [self addChild:backcloud];
    
    //    [self addCloud];
    actionAddMonster = [SKAction runBlock:^{
        [self addCloud];
    }];
    actionWaitNextMonster = [SKAction waitForDuration:1.5];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[actionAddMonster,actionWaitNextMonster]]]];
    //...
}

-(void)addCloud{
    //一号云
    SKSpriteNode *Cloud1 = [SKSpriteNode spriteNodeWithImageNamed:@"cloud1.png"];
    Cloud1.size = CGSizeMake(120, 100);
    Cloud1.position = CGPointMake(414+50, 500);
    [self addChild:Cloud1];
    
    SKAction *actionMove1 = [SKAction moveTo:CGPointMake(-Cloud1.size.width/2, 500) duration:2.3];
    SKAction *removeMoveDone = [SKAction runBlock:^{
        [Cloud1 removeFromParent];
    }];
    [Cloud1 runAction:[SKAction sequence:@[actionMove1,removeMoveDone]]];
    
    //二号云
    SKSpriteNode *Cloud2 = [SKSpriteNode spriteNodeWithImageNamed:@"cloud2.png"];
    Cloud2.size = CGSizeMake(140, 110);
    Cloud2.position = CGPointMake(414+50, 420);
    [self addChild:Cloud2];
    
    SKAction *actionMove2 = [SKAction moveTo:CGPointMake(-Cloud1.size.width/2, 420) duration:3.0];
    SKAction *removeMoveDone2 = [SKAction runBlock:^{
        [Cloud2 removeFromParent];
    }];
    [Cloud2 runAction:[SKAction sequence:@[actionMove2,removeMoveDone2]]];
    
    //三号云
    SKSpriteNode *Cloud3 = [SKSpriteNode spriteNodeWithImageNamed:@"cloud3.png"];
    Cloud3.size = CGSizeMake(120, 100);
    Cloud3.position = CGPointMake(414+50, 350);
    [self addChild:Cloud3];
    
    SKAction *actionMove3 = [SKAction moveTo:CGPointMake(-Cloud1.size.width/2, 350) duration:1.5];
    SKAction *removeMoveDone3 = [SKAction runBlock:^{
        [Cloud3 removeFromParent];
    }];
    [Cloud3 runAction:[SKAction sequence:@[actionMove3,removeMoveDone3]]];
    
    //四号云
    SKSpriteNode *Cloud4 = [SKSpriteNode spriteNodeWithImageNamed:@"cloud1.png"];
    Cloud4.size = CGSizeMake(120, 100);
    Cloud4.position = CGPointMake(414+50, 290);
    [self addChild:Cloud4];
    
    SKAction *actionMove4 = [SKAction moveTo:CGPointMake(-Cloud1.size.width/2, 290) duration:2.6];
    SKAction *removeMoveDone4 = [SKAction runBlock:^{
        [Cloud4 removeFromParent];
    }];
    [Cloud4 runAction:[SKAction sequence:@[actionMove4,removeMoveDone4]]];
    
}

-(void)update:(NSTimeInterval)currentTime{
    
}

@end
