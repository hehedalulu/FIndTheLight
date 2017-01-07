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
//#import "LLGetStep.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    (void)application;
    (void)launchOptions;
    _active = true;
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = @"d4ab078d2a2f09d13723b20ec10c6788";
    [Bmob registerWithAppKey:@"4a45d08fb950978f1139c119c32a061b"];
 /*
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
*/
    
//如果是第一次打开
   if (![[NSUserDefaults standardUserDefaults]valueForKey:@"isFirst"]) {
   
    [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isFirst"];
    //第一次打开就存一个today 判断是否当天第一次打开应用
    NSDate *firstOpenAPP = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:firstOpenAPP forKey:@"today"];
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"Energy"];
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"NowDayEnergy"];
    //光球开始计时？
    [[NSUserDefaults standardUserDefaults] setObject:firstOpenAPP forKey:@"firstOpenAPPString"];
       NSLog(@"第一次打开应用,初始化能量");
       //保存当前步数到@"Energy"中
   }else{
    [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"isFirst"];
   }
    
//不是第一次打开
//判断是否是当天首次打开 如果是在当天首次打开应用的话 初始化当天能量值
    NSDate *oldday = [[NSUserDefaults standardUserDefaults]valueForKey:@"today"];
    NSDate *today = [NSDate date];
    
    if (![self isSameDayForDate:oldday andDate:today]){//不一样 所以是首次打开
        //如果是当天首次打开应用  当天的当天步数纪录调整为0
        [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"NowDayEnergy"];
        [[NSUserDefaults standardUserDefaults]setObject:today forKey:@"today"];
        NSLog(@"非第一次当天首次打开应用,当前能量是%@",
              [[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"]
              );
    }else{//一样 有可能是第一次次打开 有可能是当天非首次打开
        //不是当天首次打开应用 将步数差加到Energy中
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isFirst"] isEqualToString:@"YES"]) {
            //如果是第一次
            //NSLog(@"第一次打开");
        }else{
            NSLog(@"当天非首次打开应用,当天能量之前为%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"]);
        }
        //[[NSUserDefaults standardUserDefaults]setValue:EnergyString forKey:@"Energy"];
        //NSLog(@"现在当天能量为%d，之前总能量是%d,现在总能量为%d",afterEnergy,Energy,result);
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

- (BOOL)isSameDayForDate:(NSDate *)date1 andDate:(NSDate*)date2

{
    
    if (nil == date1 || nil == date2)
        
    {
        return NO;
    }
//    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    NSDateComponents *components = [calendar components:(NSCalendarUnitEra |NSCalendarUnitYear | NSCalendarUnitMonth  | NSCalendarUnitDay)  fromDate:date1];
//    
//    NSDate *OneDate = [calendar dateFromComponents:components];
//
//    components = [calendar components:(NSCalendarUnitEra |NSCalendarUnitYear | NSCalendarUnitMonth  | NSCalendarUnitDay) fromDate:date2];
//    
//    NSDate *OtherDate = [calendar dateFromComponents:components];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
     NSString *DateString1 = [dateFormatter stringFromDate:date1];
     NSString *DateString2 = [dateFormatter stringFromDate:date2];
    
    return ([DateString1 isEqualToString:DateString2]);
    
}

@end
