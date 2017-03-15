//
//  LLFilterModel.h
//  FIndTheLight
//
//  Created by Wll on 17/2/18.
//  Copyright © 2017年 CherryWang. All rights reserved.
//


#import "LLFilterSuiPian.h"

@interface LLFilterModel : NSObject

@property (nonatomic) BOOL LLFilterHadMixed;

@property (nonatomic) NSString *LLFilterModelName;
@property (nonatomic) int LLFilterLevel;
@property (nonatomic) int LLFilterHadProgressCount;
@property (nonatomic) int LLFilterSuiPianCount;

@property (nonatomic) LLFilterSuiPian *suiPian1;
@property (nonatomic) int LLMixSuiPianNeed1;
@property (nonatomic) int LLMixSuiPianHad1;
@property int FilterSuiPianFinished1;

@property (nonatomic) LLFilterSuiPian *suiPian2;
@property (nonatomic) int LLMixSuiPianNeed2;
@property (nonatomic) int LLMixSuiPianHad2;
@property int FilterSuiPianFinished2;

@property (nonatomic) LLFilterSuiPian *suiPian3;
@property (nonatomic) int LLMixSuiPianNeed3;
@property (nonatomic) int LLMixSuiPianHad3;
@property int FilterSuiPianFinished3;


-(void)setModelContent;
@end
