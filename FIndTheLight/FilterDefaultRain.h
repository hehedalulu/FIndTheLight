//
//  FilterDefaultRain.h
//  FIndTheLight
//
//  Created by Wll on 17/2/5.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FilterDefaultRain : SKScene{
    BOOL hasCreatRain;
    SKEmitterNode *rain;
}
@property (nonatomic) CGFloat Filter_rainNumber;

@end
