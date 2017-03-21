//
//  AppDelegate.h
//  FIndTheLight
//
//  Created by Wll on 16/11/25.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLJudgeNetManager.h"
#import "LLSuiPianManager.h"
#import "LLFilterManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    LLJudgeNetManager *netmanager;
}

@property (strong, nonatomic) UIWindow *window;
@property (atomic) bool active;

@end

