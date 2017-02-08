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
}
//@property (nonatomic)CGFloat waitTime;

@end
