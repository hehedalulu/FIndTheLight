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
//    NSString *rainPath = [[NSBundle mainBundle]pathForResource:@"SmallRain" ofType:@"sks"];r
//    
//    SKEmitterNode *rain = [NSKeyedUnarchiver unarchiveObjectWithFile:rainPath];
//    rain.position = CGPointMake(212, 368);
//    rain.particleColor = [SKColor whiteColor];
//    [self addChild:rain];
 
//    self.backgroundColor = [SKColor darkGrayColor];
    
    
    SKSpriteNode *backcloud = [SKSpriteNode spriteNodeWithImageNamed:@"filter_cloud5.png"];
    backcloud.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2,
                                     [UIScreen mainScreen].bounds.size.height*0.92);
    backcloud.size = CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                [UIScreen mainScreen].bounds.size.height*0.16);
    [self addChild:backcloud];
    
    SKAction *backGroundBig = [SKAction resizeByWidth:10.f height:10.f duration:0.5];
    SKAction *backGroundSmall = [SKAction resizeByWidth:-10.f height:-10.f duration:0.5];
    [backcloud runAction:[SKAction repeatActionForever:[SKAction sequence:@[backGroundBig,backGroundSmall]]]];
    
    timeinterval = _waitTime;
    [self initTrack1];
    [self performSelector:@selector(initTrack2) withObject:nil afterDelay:1.5];
    [self performSelector:@selector(initTrack3) withObject:nil afterDelay:0.5];
    [self performSelector:@selector(initTrack4) withObject:nil afterDelay:1.0];
    
}



-(void)initTrack1{
    SKAction *actionAddMonster1 = [SKAction runBlock:^{
        [self addCloud1];
    }];
    SKAction *actionWaitInterval = [SKAction waitForDuration:timeinterval];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[actionAddMonster1,actionWaitInterval]]]];
}

-(void)initTrack2{
        SKAction *actionAddMonster1 = [SKAction runBlock:^{
            [self addCloud2];
        }];
        SKAction *actionWaitInterval = [SKAction waitForDuration:timeinterval];
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[actionAddMonster1,actionWaitInterval]]]];
    
}

-(void)initTrack3{
    SKAction *actionAddMonster1 = [SKAction runBlock:^{
        [self addCloud3];
    }];
    SKAction *actionWaitInterval = [SKAction waitForDuration:timeinterval];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[actionAddMonster1,actionWaitInterval]]]];
}

-(void)initTrack4{
    SKAction *actionAddMonster1 = [SKAction runBlock:^{
        [self addCloud4];
    }];
    SKAction *actionWaitInterval = [SKAction waitForDuration:timeinterval];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[actionAddMonster1,actionWaitInterval]]]];
}
-(void)addCloud1{
    //一号云
    Cloud1 = [SKSpriteNode spriteNodeWithImageNamed:@"cloud1.png"];
    Cloud1.size = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.29,
                             [UIScreen mainScreen].bounds.size.height*0.08);
    Cloud1.position = CGPointMake([UIScreen mainScreen].bounds.size.width+50,
                                  [UIScreen mainScreen].bounds.size.height*0.9);
    [self addChild:Cloud1];
    
    SKAction *actionMove1 = [SKAction moveTo:CGPointMake(-Cloud1.size.width/2,
                                                         [UIScreen mainScreen].bounds.size.height*0.93) duration:5.0];
    SKAction *removeMoveDone = [SKAction runBlock:^{
        [Cloud1 removeFromParent];
    }];
    
    SKAction *Cloud1Big = [SKAction moveByX: 0 y: -40 duration: 0.2];
    SKAction *Cloud1Small = [SKAction moveByX: 0 y: 40 duration: 0.2];
    SKAction *Bigsmall1 = [SKAction group:@[Cloud1Big,Cloud1Small]];
    SKAction *repeatBigSmall = [SKAction repeatAction:Bigsmall1 count:5];
    
    SKAction *group1 = [SKAction group:@[repeatBigSmall,actionMove1]];
    
    [Cloud1 runAction:[SKAction sequence:@[group1,removeMoveDone]]];
}


-(void)addCloud2{
    //二号云
    Cloud2 = [SKSpriteNode spriteNodeWithImageNamed:@"cloud2.png"];
    Cloud2.size = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.17,
                             [UIScreen mainScreen].bounds.size.height*0.066);
    Cloud2.position = CGPointMake([UIScreen mainScreen].bounds.size.width+50,
                                  [UIScreen mainScreen].bounds.size.height*0.88);
    [self addChild:Cloud2];
    
    
    SKAction *actionMove2 = [SKAction moveTo:CGPointMake(-Cloud2.size.width/2,
                                                         [UIScreen mainScreen].bounds.size.height*0.88) duration:4.0];
    SKAction *removeMoveDone2 = [SKAction runBlock:^{
        [Cloud2 removeFromParent];
    }];
    
//    SKAction *group2 = [SKAction group:@[repeatBigSmall,actionMove2]];
    [Cloud2 runAction:[SKAction sequence:@[actionMove2,removeMoveDone2]]];
}


-(void)addCloud3{
    //三号云
    Cloud3 = [SKSpriteNode spriteNodeWithImageNamed:@"cloud3.png"];
    Cloud3.size = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.17,
                             [UIScreen mainScreen].bounds.size.height*0.066);
    Cloud3.position = CGPointMake([UIScreen mainScreen].bounds.size.width+50,
                                  [UIScreen mainScreen].bounds.size.height*0.82);
    [self addChild:Cloud3];
    
    SKAction *actionMove3 = [SKAction moveTo:CGPointMake(-Cloud3.size.width/2,
                                                         [UIScreen mainScreen].bounds.size.height*0.82) duration:4.5];
    SKAction *removeMoveDone3 = [SKAction runBlock:^{
        [Cloud3 removeFromParent];
    }];
//    SKAction *group3 = [SKAction group:@[repeatBigSmall,actionMove3]];
    [Cloud3 runAction:[SKAction sequence:@[actionMove3,removeMoveDone3]]];
    
}

-(void)addCloud4{
    //四号云
    Cloud4 = [SKSpriteNode spriteNodeWithImageNamed:@"cloud4.png"];
    Cloud4.size = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.181,
                             [UIScreen mainScreen].bounds.size.height*0.072);
    Cloud4.position = CGPointMake([UIScreen mainScreen].bounds.size.width+50,
                                  [UIScreen mainScreen].bounds.size.height*0.78);
    [self addChild:Cloud4];
    
    SKAction *actionMove4 = [SKAction moveTo:CGPointMake(-Cloud4.size.width/2,
                                                         [UIScreen mainScreen].bounds.size.height*0.78) duration:5.0];
    SKAction *removeMoveDone4 = [SKAction runBlock:^{
        [Cloud4 removeFromParent];
    }];
//    SKAction *group4 = [SKAction group:@[repeatBigSmall,actionMove4]];
    [Cloud4 runAction:[SKAction sequence:@[actionMove4,removeMoveDone4]]];
    
}
-(void)addCloud{
    
}

-(void)update:(NSTimeInterval)currentTime{
    timeinterval = _waitTime;
    NSLog(@"间隔时间%f",timeinterval);
//    if(timeinterval==1.5){
//        [Cloud4 removeFromParent];
        
//    }
        
}



@end
