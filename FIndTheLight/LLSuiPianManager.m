//
//  LLSuiPianManager.m
//  FIndTheLight
//
//  Created by Wll on 17/3/15.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLSuiPianManager.h"
#import "LLSuiPian.h"
#import "LLFilterManager.h"
@implementation LLSuiPianManager

-(void)SetSuiPianValue{
    LLSuiPian *SuiPian1 = [[LLSuiPian alloc]init];
    SuiPian1.LLSuiPianName = @"naiqi";
    SuiPian1.LLSuiPianPicName = @"naiqi.png";
    SuiPian1.SuiPianHasShow = NO;
    SuiPian1.LLSuiPianCount = 0;
    
    LLSuiPian *SuiPian2 = [[LLSuiPian alloc]init];
    SuiPian2.LLSuiPianName = @"boli";
    SuiPian2.LLSuiPianPicName = @"boli.png";
    SuiPian2.SuiPianHasShow = NO;
    SuiPian2.LLSuiPianCount = 0;
    
    LLSuiPian *SuiPian3 = [[LLSuiPian alloc]init];
    SuiPian3.LLSuiPianName = @"wusi";
    SuiPian3.LLSuiPianPicName = @"wusi.png";
    SuiPian3.SuiPianHasShow = NO;
    SuiPian3.LLSuiPianCount = 0;

    LLSuiPian *SuiPian4 = [[LLSuiPian alloc]init];
    SuiPian4.LLSuiPianName = @"aiyi";
    SuiPian4.LLSuiPianPicName = @"aiyi.png";
    SuiPian4.SuiPianHasShow = NO;
    SuiPian4.LLSuiPianCount = 0;
    
    LLSuiPian *SuiPian5 = [[LLSuiPian alloc]init];
    SuiPian5.LLSuiPianName = @"jingti";
    SuiPian5.LLSuiPianPicName = @"jingti.png";
    SuiPian5.SuiPianHasShow = NO;
    SuiPian5.LLSuiPianCount = 0;

    LLSuiPian *SuiPian6 = [[LLSuiPian alloc]init];
    SuiPian6.LLSuiPianName = @"Tengman";
    SuiPian6.LLSuiPianPicName = @"tengman.png";
    SuiPian6.SuiPianHasShow = NO;
    SuiPian6.LLSuiPianCount = 0;
    
    LLSuiPian *SuiPian7 = [[LLSuiPian alloc]init];
    SuiPian7.LLSuiPianName = @"jianjiao";
    SuiPian7.LLSuiPianPicName = @"jianjiao.png";
    SuiPian7.SuiPianHasShow = NO;
    SuiPian7.LLSuiPianCount = 0;
    
    LLSuiPian *SuiPian8 = [[LLSuiPian alloc]init];
    SuiPian8.LLSuiPianName = @"nanguabing";
    SuiPian8.LLSuiPianPicName = @"nanguabing.png";
    SuiPian8.SuiPianHasShow = NO;
    SuiPian8.LLSuiPianCount = 0;
    
    LLSuiPian *SuiPian9 = [[LLSuiPian alloc]init];
    SuiPian9.LLSuiPianName = @"chibang";
    SuiPian9.LLSuiPianPicName = @"chibang.png";
    SuiPian9.SuiPianHasShow = NO;
    SuiPian9.LLSuiPianCount = 0;
    
    
    LLSuiPian *SuiPian10 = [[LLSuiPian alloc]init];
    SuiPian10.LLSuiPianName = @"faguangTail";
    SuiPian10.LLSuiPianPicName = @"faguangTail.png";
    SuiPian10.SuiPianHasShow = NO;
    SuiPian10.LLSuiPianCount = 0;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        //存储数据
        [realm  addObject:SuiPian1];
        [realm  addObject:SuiPian2];
        [realm  addObject:SuiPian3];
        [realm  addObject:SuiPian4];
        [realm  addObject:SuiPian5];
        [realm  addObject:SuiPian6];
        [realm  addObject:SuiPian7];
        [realm  addObject:SuiPian8];
        [realm  addObject:SuiPian9];
        [realm  addObject:SuiPian10];
        //写入数据库
        [realm commitWriteTransaction];
    }];
    
//    LLFilterManager *filtermanager = [[LLFilterManager alloc]init];
//    [filtermanager SetFilterValue];
}
@end
