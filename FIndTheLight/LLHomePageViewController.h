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

@interface LLHomePageViewController : UIViewController<AMapLocationManagerDelegate,UIViewControllerTransitioningDelegate>{
    AMapLocationManager *locationManager;
}

@property (nonatomic, weak) UIView * LLsecondView;

@property(nonatomic, strong) OpenGLView *glView;

@property (nonatomic, strong) UILabel *displayLabel;

@end
