//
//  LLLocalSuiPian.m
//  FIndTheLight
//
//  Created by Wll on 17/2/16.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLLocalSuiPian.h"

@implementation LLLocalSuiPian

-(void)RandomSetLocalSuiPian{
    int Possible = arc4random() % 101;
    NSLog(@"碎片生成的随机数时%D",Possible);
    if (Possible>=0 && Possible<=60) {
        UIImage *Defualt_01_Stick = [UIImage imageNamed:@"LocalSuiPian1.png"];
        [self setLLLocalSuiPianImage:Defualt_01_Stick];
        
        NSString *Defualt_01_StickString = @"小木棒";
        [self setLLLocalSuiPianNameString:Defualt_01_StickString];
        
        NSString *Defualt_01_StickKey = @"Defualt_01_StickCount";
        [self SuiPianCountAddWithKey:Defualt_01_StickKey];
//        [self setLLLocalSuiPianCount:[[NSUserDefaults standardUserDefaults]valueForKey:Defualt_01_StickKey]];
        NSString *Suipiancount = [[NSUserDefaults standardUserDefaults]valueForKey:Defualt_01_StickKey];
        int Count = Suipiancount.intValue;
        [self setLLLocalSuiPianCount:[NSString stringWithFormat:@"库存%d个",Count]];

    }else if (Possible<=100 && Possible >= 40){
        UIImage *Defualt_01_Match = [UIImage imageNamed:@"LocalSuiPian2.png"];
        [self setLLLocalSuiPianImage:Defualt_01_Match];
        
        NSString *Defualt_01_MatchString = @"红红火柴头";
        [self setLLLocalSuiPianNameString:Defualt_01_MatchString];
        
        NSString *Defualt_01_MatchKey = @"Defualt_01_MatchCount";
        [self SuiPianCountAddWithKey:Defualt_01_MatchKey];
        NSString *Suipiancount = [[NSUserDefaults standardUserDefaults]valueForKey:Defualt_01_MatchKey];
        int Count = Suipiancount.intValue;
        [self setLLLocalSuiPianCount:[NSString stringWithFormat:@"库存%d个",Count]];
    }
}

-(void)SuiPianCountAddWithKey:(NSString *)OldString{
    if ([[NSUserDefaults standardUserDefaults]valueForKey:OldString]) {
        NSString *OldCount = [[NSUserDefaults standardUserDefaults]valueForKey:OldString];
        int NewCountint = OldCount.intValue+1;
        NSString *NewCount = [NSString stringWithFormat:@"%d",NewCountint];
        [[NSUserDefaults standardUserDefaults]setValue:NewCount forKey:OldString];
    }else{
        [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:OldString];
    }
}


@end
