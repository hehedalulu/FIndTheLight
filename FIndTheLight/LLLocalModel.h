//
//  LLLocalModel.h
//  FIndTheLight
//
//  Created by Wll on 17/3/8.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Realm/Realm.h>
#import <UIKit/UIKit.h>
@interface LLLocalModel : RLMObject

@property (nonatomic,copy) NSString *LLLocalModelNameString;
@property (nonatomic,copy) NSString *LLLocalModelmageName;
@property (nonatomic,copy) NSString *LLLocalModelLevelImageName;
@property (nonatomic,copy) NSString *LLLocalLightValueString;

@end
