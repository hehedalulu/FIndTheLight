//
//  AppDelegate.m
//  FIndTheLight
//
//  Created by Wll on 16/11/25.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "AppDelegate.h"
#include "easyar/utility.hpp"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <BmobSDK/Bmob.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    (void)application;
    (void)launchOptions;
    _active = true;
    [AMapServices sharedServices].apiKey = @"d4ab078d2a2f09d13723b20ec10c6788";
    [Bmob registerWithAppKey:@"4a45d08fb950978f1139c119c32a061b"];
    
    BmobUser *bUser = [BmobUser currentUser];
    if (bUser) {
        //进行操作
        //取出sb
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [sb instantiateViewControllerWithIdentifier:@"LLHomePage"];
        self.window.rootViewController = nav;
        
    }else{
        //对象为空时，可打开用户注册界面
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *first = [sb instantiateViewControllerWithIdentifier:@"LLLoginView"];
        
        self.window.rootViewController = first;
        //        GuideViewController *loginVC = [[GuideViewController alloc]init];
        //        self.window.rootViewController = loginVC;
    }

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    (void)application;
    _active = false;
    EasyAR::onPause();
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    (void)application;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    (void)application;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    (void)application;
    _active = true;
    EasyAR::onResume();
}


- (void)applicationWillTerminate:(UIApplication *)application {
    (void)application;
    _active = false;
}


@end
