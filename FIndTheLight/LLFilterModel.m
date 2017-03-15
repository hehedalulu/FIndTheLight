//
//  LLFilterModel.m
//  FIndTheLight
//
//  Created by Wll on 17/2/18.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLFilterModel.h"
/*
 默认滤镜
 开学季
 */

@implementation LLFilterModel

//-(void)setLLFilterModelName:(NSString *)LLFilterModelName{
//}

-(void)setModelContent{
    _suiPian1 = [[LLFilterSuiPian alloc]init];
    _suiPian2 = [[LLFilterSuiPian alloc]init];
    _suiPian3 = [[LLFilterSuiPian alloc]init];
    
    if ([_LLFilterModelName isEqualToString: @"开学季"]) {
        self.LLFilterLevel = 0;
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"NewTermFilterHadFinshed"] isEqualToString:@"Yes"]) {
            self.LLFilterHadMixed = YES;
        }else{
            self.LLFilterHadMixed = NO;
            
            
            self.suiPian1.SuiPianExist = YES;
            self.suiPian1.LLFilterSuiPianName = @"尖叫";
            self.suiPian1.LLSuiPianTotalCount = 0;
            self.suiPian1.SuiPianHasShow = NO;
            self.LLMixSuiPianNeed1 = 5;
            self.LLMixSuiPianHad1 = 0;
            if (!self.suiPian1.SuiPianHasShow) {
            //如果碎片没出现过 不显示
                self.FilterSuiPianFinished1 = 0;
            }else if(self.LLMixSuiPianNeed1 == self.LLMixSuiPianHad1 && (self.LLMixSuiPianHad1 != 0)){
            //如果所需碎片数量 ＝ 现有碎片数量 且先有碎片数量 ！＝0
            //显示已完成
                self.FilterSuiPianFinished1 = 1;
            }else{
                self.FilterSuiPianFinished1 = 2;
            }
            
            
            self.suiPian2.SuiPianExist = YES;
            self.suiPian2.LLFilterSuiPianName = @"木棒";
            self.suiPian2.LLSuiPianTotalCount =5;
            self.suiPian2.SuiPianHasShow = YES;
            self.LLMixSuiPianNeed2 = 10;
            self.LLMixSuiPianHad2 = 5;
            if (!self.LLMixSuiPianNeed2) {
                //如果碎片mcx 不显示
                self.FilterSuiPianFinished2 = 0;
            }else if(self.LLMixSuiPianNeed2 == self.LLMixSuiPianHad2 && (self.LLMixSuiPianHad2 != 0)){
                //如果所需碎片数量 ＝ 现有碎片数量 且先有碎片数量 ！＝0
                //显示已完成
                self.FilterSuiPianFinished1 = 1;
            }else{
                self.FilterSuiPianFinished1 = 2;
            }
            
            self.suiPian3.SuiPianExist = YES;
            self.suiPian3.LLFilterSuiPianName = @"金属";
            self.suiPian3.LLSuiPianTotalCount = 0;
            self.suiPian3.SuiPianHasShow = YES;
            self.LLMixSuiPianNeed3 = 15;
            self.LLMixSuiPianHad3 = 15;
            if (!self.suiPian2.SuiPianHasShow) {
                //如果碎片数量为零 不显示
                self.FilterSuiPianFinished3 = 0;
            }else if(self.LLMixSuiPianNeed3 == self.LLMixSuiPianHad3 && (self.LLMixSuiPianHad3 != 0)){
                //如果所需碎片数量 ＝ 现有碎片数量 且先有碎片数量 ！＝0
                //显示已完成
                self.FilterSuiPianFinished3 = 1;
            }else{
                self.FilterSuiPianFinished3 = 2;
            }
            
            if (self.suiPian1.SuiPianExist)
                _LLFilterSuiPianCount++;
            if(self.suiPian2.SuiPianExist)
                _LLFilterSuiPianCount++;
            if(self.suiPian3.SuiPianExist)
                _LLFilterSuiPianCount++;
            NSLog(@"开学季的碎片种类有%d",_LLFilterSuiPianCount);
            
        }
        

    }if ([_LLFilterModelName isEqualToString: @"测试滤镜1"]) {
        self.LLFilterLevel = 0;
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"NewTermFilterHadFinshed"] isEqualToString:@"Yes"]) {
            self.LLFilterHadMixed = YES;
        }else{
            self.LLFilterHadMixed = NO;
            
            
            self.suiPian1.SuiPianExist = YES;
            self.suiPian1.LLFilterSuiPianName = @"Part1";
            self.suiPian1.LLSuiPianTotalCount = 0;
            self.suiPian1.SuiPianHasShow = YES;
            self.LLMixSuiPianNeed1 = 5;
            self.LLMixSuiPianHad1 = 5;
            if (!self.suiPian1.SuiPianHasShow) {
                //如果碎片数量为零 不显示
                self.FilterSuiPianFinished1 = 0;
            }else if(self.LLMixSuiPianNeed1 == self.LLMixSuiPianHad1 && (self.LLMixSuiPianHad1 != 0)){
                //如果所需碎片数量 ＝ 现有碎片数量 且先有碎片数量 ！＝0
                //显示已完成
                self.FilterSuiPianFinished1 = 1;
            }else{
                self.FilterSuiPianFinished1 = 2;
            }
            
            
            self.suiPian2.SuiPianExist = YES;
            self.suiPian2.LLFilterSuiPianName = @"Part2";
            self.suiPian2.LLSuiPianTotalCount = 10;
            self.suiPian2.SuiPianHasShow = YES;
            self.LLMixSuiPianNeed2 = 10;
            self.LLMixSuiPianHad2 = 5;
            if (!self.suiPian2.SuiPianHasShow) {
                //如果碎片数量为零 不显示
                self.FilterSuiPianFinished2 = 0;
            }else if(self.LLMixSuiPianNeed2 == self.LLMixSuiPianHad2 && (self.LLMixSuiPianHad2 != 0)){
                //如果所需碎片数量 ＝ 现有碎片数量 且先有碎片数量 ！＝0
                //显示已完成
                self.FilterSuiPianFinished1 = 1;
            }else{
                self.FilterSuiPianFinished1 = 2;
            }
            
            self.suiPian3.SuiPianExist = YES;
            self.suiPian3.LLFilterSuiPianName = @"Part3";
            self.suiPian3.LLSuiPianTotalCount =0;
            self.suiPian3.SuiPianHasShow = NO;
            self.LLMixSuiPianNeed3 = 15;
            self.LLMixSuiPianHad3 = 0;
            if (!self.suiPian3.SuiPianHasShow) {
                //如果碎片数量为零 不显示
                self.FilterSuiPianFinished3 = 0;
            }else if(self.LLMixSuiPianNeed3 == self.LLMixSuiPianHad3 && (self.LLMixSuiPianHad3 != 0)){
                //如果所需碎片数量 ＝ 现有碎片数量 且先有碎片数量 ！＝0
                //显示已完成
                self.FilterSuiPianFinished3 = 1;
            }else{
                self.FilterSuiPianFinished3 = 2;
            }
            
            if (self.suiPian1.SuiPianExist)
                _LLFilterSuiPianCount++;
            if(self.suiPian2.SuiPianExist)
                _LLFilterSuiPianCount++;
            if(self.suiPian3.SuiPianExist)
                _LLFilterSuiPianCount++;
            NSLog(@"测试滤镜1的碎片种类有%d",_LLFilterSuiPianCount);
            
        }
        
        
    }if ([_LLFilterModelName isEqualToString: @"测试滤镜2"]) {
        self.LLFilterLevel = 0;
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"NewTermFilterHadFinshed"] isEqualToString:@"Yes"]) {
            self.LLFilterHadMixed = YES;
        }else{
            self.LLFilterHadMixed = NO;
            
            
            self.suiPian1.SuiPianExist = YES;
            self.suiPian1.LLFilterSuiPianName = @"Part4";
            self.suiPian1.LLSuiPianTotalCount = 0;
            self.suiPian1.SuiPianHasShow = YES;
            self.LLMixSuiPianNeed1 = 5;
            self.LLMixSuiPianHad1 = 5;
            if (!self.suiPian1.SuiPianHasShow) {
                //如果碎片数量为零 不显示
                self.FilterSuiPianFinished1 = 0;
            }else if(self.LLMixSuiPianNeed1 == self.LLMixSuiPianHad1 && (self.LLMixSuiPianHad1 != 0)){
                //如果所需碎片数量 ＝ 现有碎片数量 且先有碎片数量 ！＝0
                //显示已完成
                self.FilterSuiPianFinished1 = 1;
            }else{
                self.FilterSuiPianFinished1 = 2;
            }
            
            
            self.suiPian2.SuiPianExist = YES;
            self.suiPian2.LLFilterSuiPianName = @"Part5";
            self.suiPian2.LLSuiPianTotalCount = 0;
            self.suiPian2.SuiPianHasShow = YES;
            self.LLMixSuiPianNeed2 = 10;
            self.LLMixSuiPianHad2 = 10;
            if (!self.suiPian2.SuiPianHasShow) {
                //如果碎片数量为零 不显示
                self.FilterSuiPianFinished2 = 0;
            }else if(self.LLMixSuiPianNeed2 == self.LLMixSuiPianHad2 && (self.LLMixSuiPianHad2 != 0)){
                //如果所需碎片数量 ＝ 现有碎片数量 且先有碎片数量 ！＝0
                //显示已完成
                self.FilterSuiPianFinished1 = 1;
            }else{
                self.FilterSuiPianFinished1 = 2;
            }
            
            self.suiPian3.SuiPianExist = YES;
            self.suiPian3.LLFilterSuiPianName = @"Part6";
            self.suiPian3.LLSuiPianTotalCount =0;
            self.suiPian3.SuiPianHasShow = YES;
            self.LLMixSuiPianNeed3 = 15;
            self.LLMixSuiPianHad3 = 15;
            if (!self.suiPian3.SuiPianHasShow) {
                //如果碎片数量为零 不显示
                self.FilterSuiPianFinished3 = 0;
            }else if(self.LLMixSuiPianNeed3 == self.LLMixSuiPianHad3 && (self.LLMixSuiPianHad3 != 0)){
                //如果所需碎片数量 ＝ 现有碎片数量 且先有碎片数量 ！＝0
                //显示已完成
                self.FilterSuiPianFinished3 = 1;
            }else{
                self.FilterSuiPianFinished3 = 2;
            }
            
            if (self.suiPian1.SuiPianExist)
                _LLFilterSuiPianCount++;
            if(self.suiPian2.SuiPianExist)
                _LLFilterSuiPianCount++;
            if(self.suiPian3.SuiPianExist)
                _LLFilterSuiPianCount++;
            NSLog(@"测试滤镜2的碎片种类有%d",_LLFilterSuiPianCount);
            
        }
        
        
    }

}
@end
