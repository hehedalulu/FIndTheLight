//
//  LLPunchManger.h
//  FIndTheLight
//
//  Created by Wll on 17/3/12.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLARPicsModel.h"
#import "LLPunchModel.h"
@interface LLPunchManger : NSObject{

}

@property (nonatomic,copy) NSString *LLPunchMangerDate;

@property (assign) int LLPunchLibraryAMCount;
@property (assign) int LLPunchLibraryPMCount;
@property (assign) int LLPunchRestaurantAMCount;
@property (assign) int LLPunchRestaurantPMCount;
@property (assign) int LLPunchTeachAMCount;
@property (assign) int LLPunchTeachPMCount;

-(void)CheckDatePunch:(NSDate *)date;
-(void)TestDatePunch:(NSDate *)date;
@end
