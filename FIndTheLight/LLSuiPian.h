//
//  LLSuiPian.h
//  FIndTheLight
//
//  Created by Wll on 17/3/15.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Realm/Realm.h>

@interface LLSuiPian : RLMObject

@property (nonatomic,copy) NSString *LLSuiPianName;
@property (nonatomic,copy) NSString *LLSuiPianPicName;
@property (nonatomic,assign) BOOL SuiPianHasShow;
@property (nonatomic) int LLSuiPianCount;

//@property 


@end
