//
//  LLJudgeNetManager.m
//  FIndTheLight
//
//  Created by Wll on 17/3/4.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLJudgeNetManager.h"
#import "AFNetworkReachabilityManager.h"
#import "JCAlertView.h"

@implementation LLJudgeNetManager

-(void)registNetChange{
    
     NSNotificationCenter  *center = [ NSNotificationCenter  defaultCenter];
    [center addObserver:self selector:@selector(ReceiveNetChange:) name:@"NetWorkChange" object:nil];
    
}

-(void)JudgeNowNetwork{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{ // 未知网络
                NSLog(@"未知网络");
                NSNotification * notice = [NSNotification notificationWithName:@"NetWorkChange" object:@"NoNet"];
                 [[NSNotificationCenter defaultCenter]postNotification:notice];
                
                NSNotification * controlnotice = [NSNotification notificationWithName:@"Control" object:@"NoNet"];
                [[NSNotificationCenter defaultCenter]postNotification:controlnotice];
                
                [JCAlertView showOneButtonWithTitle:@"" Message:@"未知网络" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"OK" Click:nil];
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:{ // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                NSNotification * notice = [NSNotification notificationWithName:@"NetWorkChange" object:@"NetBroke"];
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
                NSNotification * controlnotice = [NSNotification notificationWithName:@"Control" object:@"NoNet"];
                [[NSNotificationCenter defaultCenter]postNotification:controlnotice];
                
                [JCAlertView showOneButtonWithTitle:@"" Message:@"没有网络 AR功能已关闭" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"OK" Click:nil];
                

                
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{ // 手机自带网络
                NSLog(@"手机自带网络");
                NSNotification * notice = [NSNotification notificationWithName:@"NetWorkChange" object:@"mobileNet"];
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
                NSNotification * controlnotice = [NSNotification notificationWithName:@"Control" object:@"HasNet"];
                [[NSNotificationCenter defaultCenter]postNotification:controlnotice];
                
                [JCAlertView showOneButtonWithTitle:@"" Message:@"切换移动网络" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"OK" Click:nil];
                
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{ // WIFI
                NSLog(@"WIFI");
                NSNotification * notice = [NSNotification notificationWithName:@"NetWorkChange" object:@"WiFiNet"];
                [[NSNotificationCenter defaultCenter]postNotification:notice];

                NSNotification * controlnotice = [NSNotification notificationWithName:@"Control" object:@"HasNet"];
                [[NSNotificationCenter defaultCenter]postNotification:controlnotice];
                
                [JCAlertView showOneButtonWithTitle:@"" Message:@"切换至Wi-Fi" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"OK" Click:nil];
                break;
            }
        }
    }]; 
    // 3.开始监控
    [mgr startMonitoring];
}

-(void)ReceiveNetChange:(NSNotification*)notification{
    if ([[notification object] isEqualToString:@"mobileNet"]) {
        NSLog(@"%@",@"当前连接的是手机移动网络");
    }else if ([[notification object] isEqualToString:@"WiFiNet"]){
        NSLog(@"%@",@"当前连接的是Wi-Fi网络");
    }else{
        NSLog(@"无网络");
    }
    
}

@end
