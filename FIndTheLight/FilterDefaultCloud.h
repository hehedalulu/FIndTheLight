//
//  FilterDefaultCloud.h
//  FIndTheLight
//
//  Created by Wll on 17/2/5.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FilterDefaultCloud : SKScene{
    BOOL hasCreatCloud;
    SKAction *actionWaitNextMonster;
    SKAction *actionAddMonster;
    NSTimeInterval timeinterval;
    
    SKSpriteNode *Cloud1;
    SKSpriteNode *Cloud2;
    SKSpriteNode *Cloud3;
    SKSpriteNode *Cloud4;
    
}
@property (nonatomic)NSTimeInterval waitTime;

@end
