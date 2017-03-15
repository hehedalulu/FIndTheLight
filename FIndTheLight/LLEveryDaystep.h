//
//  LLEveryDaystep.h
//  FIndTheLight
//
//  Created by Wll on 17/3/11.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Realm/Realm.h>

@interface LLEveryDaystep : RLMObject

@property(copy) NSString *LLEverydayWeekday;
@property(copy) NSString *LLEverydayDate;
@property(copy) NSString *LLEveryDateString;
@property(copy) NSString *LLEverydayStep;
@property(copy) NSString *HasLogthisday;
//@property NSInteger id;



@end
