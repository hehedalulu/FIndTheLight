//
//  LLVIewAnimation.h
//  FIndTheLight
//
//  Created by Wll on 17/2/13.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <POP/POP.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LLModelView.h"
@interface LLVIewAnimation : NSObject{
    NSNotification *ModelAppearNotice;
    NSNotification *SuiPianAppearNotice;
}

-(void)LocalModelAppearAnimationWithImgView:(UIImageView *)imageView;
-(void)LocalModelDisAppearAnimationWithImgView:(UIImageView *)imageView;

-(void)LocalModelLevelAppearAnimationWithImge:(UIImageView *)imageView;
-(void)LocalModelLevelDisAppearAnimationWithImge:(UIImageView *)imageView;


-(void)LocalModelNameAppearAnimationWithLabel:(UILabel *)label;
-(void)LocalModelNameDisAppearAnimationWithLabel:(UILabel *)label;

-(void)LightBallMove:(UIImageView*)imageView;
-(void)LightValueMove:(UILabel *)label;


//

-(void)LocalSuiPianAppearWithImg:(UIImageView *)imageView;
-(void)LocalSuiPianNameAppearWithLabel:(UILabel *)label;
-(void)LocalSuiPianCountWithLabel:(UILabel *)label;


-(void)LocalSuiPianDisAppearWithImg:(UIImageView *)imageView;
-(void)LocalSuiPianNameDisAppearWithLabel:(UILabel *)label;
-(void)LocalSuiPianCountDisWithLabel:(UILabel *)label;
@end
