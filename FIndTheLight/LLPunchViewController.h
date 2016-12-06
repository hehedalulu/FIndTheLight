//
//  LLPunchViewController.h
//  UniversityPokemon
//
//  Created by Wll on 16/11/13.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>


@interface LLPunchViewController : UIViewController<iCarouselDataSource, iCarouselDelegate,MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>


@end
