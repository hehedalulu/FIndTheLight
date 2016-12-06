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
#import "iCarousel.h"

@interface LLHomePageViewController : UIViewController<AMapLocationManagerDelegate,iCarouselDataSource, iCarouselDelegate>{
    AMapLocationManager *locationManager;
    
    iCarousel *icarousel;
    NSMutableArray *HintImagesArray;
}

@property (nonatomic, weak) UIView * LLsecondView;

@property(nonatomic, strong) OpenGLView *glView;

@property (nonatomic, strong) UILabel *displayLabel;

@end
