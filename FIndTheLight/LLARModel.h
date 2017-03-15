//
//  LLARModel.h
//  FIndTheLight
//
//  Created by Wll on 17/3/8.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Realm/Realm.h>
#import <UIKit/UIKit.h>

@interface LLARModel : RLMObject

@property (nonatomic,copy) NSString *LLARModelName;
@property (nonatomic,copy) NSString *LLARModelImageName;
@property (nonatomic,copy) NSString *LLARModelLevelImageName;
@property (nonatomic,copy) NSString *LLARLightValueString;

@end
