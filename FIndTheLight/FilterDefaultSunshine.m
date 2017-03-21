//
//  FilterDefaultSunshine.m
//  FIndTheLight
//
//  Created by Wll on 17/2/5.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "FilterDefaultSunshine.h"

@implementation FilterDefaultSunshine
- (void)didMoveToView:(SKView *)view {
    
    if (!hasCreatSunshine) {
        [self CreatSunshine];
        hasCreatSunshine = YES;
        //        SKAction *actionAddMonster = [SKAction runBlock:^{
        //            [self CreatSunshine];
        //        }];
        //        [self runAction:[SKAction repeatActionForever:actionAddMonster]];
    }
}

-(void)CreatSunshine{

    self.backgroundColor = [SKColor clearColor];
    //彩虹
    SKSpriteNode *rainbow = [SKSpriteNode spriteNodeWithImageNamed:@"rainbow.png"];
    rainbow.position = CGPointMake(280, 530);
    rainbow.size = CGSizeMake(330, 200);
    [self addChild:rainbow];
    
    SKAction *rainbowup = [SKAction moveToY:560 duration:0.5];
    SKAction *rainbowdown = [SKAction moveToY:540 duration:0.5];
    [rainbow runAction:[SKAction repeatActionForever:[SKAction sequence:@[rainbowup,rainbowdown]]]];
    
    //太阳
    SKSpriteNode *sun = [SKSpriteNode spriteNodeWithImageNamed:@"sun.png"];
    sun.position = CGPointMake(130, 600);
    sun.size = CGSizeMake(130, 130);
    [self addChild:sun];
    
    SKAction *sunRoate = [SKAction rotateByAngle:10 duration:2.0];
    [sun runAction:[SKAction repeatActionForever:sunRoate]];
    
    //镜头光晕
    SKSpriteNode *guangyun = [SKSpriteNode spriteNodeWithImageNamed:@"hexagon.png"];
    guangyun.position = CGPointMake(100, 570);
    guangyun.size = CGSizeMake(80, 80);
    guangyun.anchorPoint = CGPointMake(2, 2);
    guangyun.alpha = 0.5;
    [self addChild:guangyun];
    
    SKAction *moveGuangYun = [SKAction rotateByAngle:10 duration:8.0];
    [guangyun runAction:[SKAction repeatActionForever:moveGuangYun]];
    
    SKSpriteNode *guangyun2 = [SKSpriteNode spriteNodeWithImageNamed:@"hexagon.png"];
    guangyun2.position = CGPointMake(80, 540);
    guangyun2.size = CGSizeMake(80, 80);
    guangyun2.anchorPoint = CGPointMake(2.5, 2.5);
    guangyun2.alpha = 0.5;
    [self addChild:guangyun2];
    
    SKAction *moveGuangYun2 = [SKAction rotateByAngle:10 duration:8.0];
    [guangyun2 runAction:[SKAction repeatActionForever:moveGuangYun2]];
    
    SKSpriteNode *guangyun3 = [SKSpriteNode spriteNodeWithImageNamed:@"hexagon.png"];
    guangyun3.position = CGPointMake(60, 510);
    guangyun3.size = CGSizeMake(80, 80);
    guangyun3.anchorPoint = CGPointMake(3, 3);
    guangyun3.alpha = 0.5;
    [self addChild:guangyun3];
    
    SKAction *moveGuangYun3 = [SKAction rotateByAngle:10 duration:8.0];
    [guangyun3 runAction:[SKAction repeatActionForever:moveGuangYun3]];
}
-(void)willMoveFromView:(SKView *)view{
    NSLog(@"离开rainbow Scene");
}
@end
