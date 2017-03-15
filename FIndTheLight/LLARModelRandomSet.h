//
//  LLARModelRandomSet.h
//  FIndTheLight
//
//  Created by Wll on 17/3/8.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLARModel.h"
#import "LLARSuiPianModel.h"

@interface LLARModelRandomSet : NSObject

-(LLARModel*)LLARRandomSetModel;

-(LLARSuiPianModel*)LLARRandomSetSuiPianWithModelName:(NSString*)ModelName;


@end
