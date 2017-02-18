//
//  LLLocalModel.h
//  FIndTheLight
//
//  Created by Wll on 17/2/15.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LLLocalModel : NSObject
@property (nonatomic) NSString *LLLocalModelNameString;
@property (nonatomic) UIImage *LLLocalModelmage;
@property (nonatomic) UIImage *LLLocalModelLevelImage;
@property (nonatomic) NSString *LLLocalLightValueString;

-(NSString *)SetLocalNameString;

-(NSString *)SetLocalLightValue;

-(UIImage *)SetLocalModelImage;

-(UIImage *)SetLocalLevelImage;

@end
