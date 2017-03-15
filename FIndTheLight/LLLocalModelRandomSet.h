//
//  LLLocalModelRandomSet.h
//  FIndTheLight
//
//  Created by Wll on 17/3/8.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLLocalModel.h"
#import "LLLocalSuiPian.h"

@interface LLLocalModelRandomSet : NSObject
-(LLLocalModel *)LLLoacalRandomSetModel;
-(LLLocalSuiPian*)LLLocalRandomSetSuiPianWithModelName:(NSString*)ModelName;
@end
