//
//  LLHomePageViewController.h
//  UniversityPokemon
//
//  Created by Wll on 16/11/12.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenGLView.h"

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "HintViewDismiss.h"
#import "HintViewPresent.h"
#import "LLHintViewController.h"

#import "LLPunchViewController.h"
#import "LLMixFilterViewController.h"
#import "LLRankViewController.h"

#import "FilterDefaultRain.h"
#import "FilterDefaultCloud.h"
#import "FilterDefaultSunshine.h"

#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

#import "LLMusicYeah.h"

@interface LLHomePageViewController : UIViewController<AMapLocationManagerDelegate,UIViewControllerTransitioningDelegate>{
    AMapLocationManager *locationManager;
    
    FilterDefaultRain *scene;
    FilterDefaultCloud *rainscene;
    FilterDefaultSunshine *sunshine;
    SKView *skView;
}

@property (nonatomic, weak) UIView * LLsecondView;

@property(nonatomic, strong) OpenGLView *glView;

@property (nonatomic, strong) UILabel *displayLabel;

@end
