//
//  LLFilter.h
//  FIndTheLight
//
//  Created by Wll on 17/3/15.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Realm/Realm.h>
#import <Foundation/Foundation.h>
#import "LLSuiPian.h"

@interface LLFilter : RLMObject

@property (copy) NSString *LLFilterName;

@property (copy) NSString *LLFilterPicName;

@property (copy) NSString *LLFilterLevel;

@property (assign) int LLFilterProgress;

@property (assign) int LLFilterSuiPianCount;

@property (assign) BOOL LLFilterHasbeenFound;

@property (assign) BOOL LLFilterHasBeenMixed;

@property LLSuiPian *suiPian1;
@property (assign) int LLsuiPian1Need;
@property (assign) int LLsuiPian1Had;
@property (assign) BOOL LLsuiPian1HasFininshed;


@property LLSuiPian *suiPian2;
@property (assign) int LLsuiPian2Need;
@property (assign) int LLsuiPian2Had;
@property (assign) BOOL LLsuiPian2HasFininshed;

@property LLSuiPian *suiPian3;
@property (assign) int LLsuiPian3Need;
@property (assign) int LLsuiPian3Had;
@property (assign) BOOL LLsuiPian3HasFininshed;
@end
