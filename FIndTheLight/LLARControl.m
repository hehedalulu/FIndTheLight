//
//  LLARControl.m
//  FIndTheLight
//
//  Created by Wll on 17/3/4.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLARControl.h"

@implementation LLARControl
//
-(BOOL)HadOpenLoction{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined )) {
        NSLog(@"定位功能可用");
        //定位功能可用
        return YES;
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        NSLog(@"定位功能不可用");
        //定位不能用
        return NO;
    }
    return NO;
}
@end
