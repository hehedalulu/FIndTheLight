//
//  LLHomePageInformationView.m
//  UniversityPokemon
//
//  Created by Wll on 16/11/20.
//  Copyright © 2016年 CherryWang. All rights reserved.

#import "LLHomePageInformationView.h"
#import "Masonry.h"
@implementation LLHomePageInformationView


- (void)drawRect:(CGRect)rect {
    UIImageView *BackgroundView = [[UIImageView alloc]init];
    BackgroundView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    BackgroundView.image = [UIImage imageNamed:@"textbox_grade"];
    [self addSubview:BackgroundView];
    
    
    UIImageView *Levelimg = [[UIImageView alloc]init];
    Levelimg.image = [UIImage imageNamed:@"icon_grade"];
    Levelimg.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.0362,
                                [UIScreen mainScreen].bounds.size.width*0.0242 ,
                                [UIScreen mainScreen].bounds.size.width*0.077,
                                [UIScreen mainScreen].bounds.size.width*0.077);
    [self addSubview:Levelimg];
    
    UIImageView *SelfIcon = [[UIImageView alloc]init];
    SelfIcon.image = [UIImage imageNamed:@"icon_user"];
    SelfIcon.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.0362,
                                [UIScreen mainScreen].bounds.size.width*0.101,
                                [UIScreen mainScreen].bounds.size.width*0.077,
                                [UIScreen mainScreen].bounds.size.width*0.077);
    [self addSubview:SelfIcon];

    UIImageView *WaitingBall = [[UIImageView alloc]init];
    WaitingBall.image = [UIImage imageNamed:@"icon_light"];
    WaitingBall.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.0362,
                                   [UIScreen mainScreen].bounds.size.width*0.181,
                                   [UIScreen mainScreen].bounds.size.width*0.077,
                                   [UIScreen mainScreen].bounds.size.width*0.077);
    [self addSubview:WaitingBall];
    
    UIImageView *Energy =  [[UIImageView alloc]init];
    Energy.image = [UIImage imageNamed:@"icon_battery"];
    Energy.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.0362,
                              [UIScreen mainScreen].bounds.size.width*0.275,
                              [UIScreen mainScreen].bounds.size.width*0.077,
                              [UIScreen mainScreen].bounds.size.width*0.077);
    [self addSubview:Energy];
    

    
    UILabel *HomeUsername = [[UILabel alloc]init];
    HomeUsername.text = @"JULIA";
    HomeUsername.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.1353,
                                    [UIScreen mainScreen].bounds.size.width*0.1208,
                                    [UIScreen mainScreen].bounds.size.width*0.3623,
                                    [UIScreen mainScreen].bounds.size.width*0.0773);
    HomeUsername.font = [UIFont fontWithName:@"Marker Felt" size:20];
//    HomeUsername.adjustsLetterSpacingToFitWidth = YES;
//    LLHomePageInformationView *llhomepageinformationView = [[LLHomePageInformationView alloc]init];
    
    [self changeWordSpaceForLabel:HomeUsername WithSpace:2];
    HomeUsername.textColor = [UIColor colorWithRed:212.0/255 green:202.0/255 blue:255.0/255 alpha:1];
    [self addSubview:HomeUsername];
    
    UILabel *HomeLevel = [[UILabel alloc]init];
    HomeLevel.text = @"LV7";
    HomeLevel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.1353,
                                 [UIScreen mainScreen].bounds.size.width*0.0434,
                                 [UIScreen mainScreen].bounds.size.width*0.3623,
                                 [UIScreen mainScreen].bounds.size.width*0.0773);
//    HomeLevel.adjustsLetterSpacingToFitWidth = YES;
    [self changeWordSpaceForLabel:HomeLevel WithSpace:2];
    HomeLevel.font = [UIFont fontWithName:@"Marker Felt" size:20];
    HomeLevel.textColor = [UIColor colorWithRed:212.0/255 green:202.0/255 blue:255.0/255 alpha:1];
    [self addSubview:HomeLevel];
    
    [self initWaitingBallValueImage];
    
    HomePhysicalBackeImage = [[UIView alloc]init];
    [self addSubview:HomePhysicalBackeImage];
    EnergyMax = [[UILabel alloc]init];
    [self addSubview:EnergyMax];
    EnergyV = [[UILabel alloc]init];
    [self addSubview:EnergyV];
    HomePhysicalValueImage = [[UIView alloc]init];
    [HomePhysicalBackeImage addSubview:HomePhysicalValueImage];
    [self initEnergyValueImage];
    
}

- (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

-(void)initWaitingBallValueImage{
    UIView *HomeIntelligenceBackImg = [[UIView alloc]init];
    HomeIntelligenceBackImg.backgroundColor = [UIColor colorWithRed:46.0/255.0 green:82.0/255.0 blue:126.0/255.0 alpha:0.5];
    HomeIntelligenceBackImg.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.1353,
                                               [UIScreen mainScreen].bounds.size.width*0.2149,
                                               [UIScreen mainScreen].bounds.size.width*0.1208,
                                               [UIScreen mainScreen].bounds.size.width*0.027);
    [HomeIntelligenceBackImg.layer setMasksToBounds:YES];
    [HomeIntelligenceBackImg.layer setCornerRadius:3
     ];
    [self addSubview:HomeIntelligenceBackImg];
    
    UILabel *WaitingMax = [[UILabel alloc]initWithFrame:
                           CGRectMake([UIScreen mainScreen].bounds.size.width*0.2681,
                                      [UIScreen mainScreen].bounds.size.width*0.198,
                                      [UIScreen mainScreen].bounds.size.width*0.068,
                                      [UIScreen mainScreen].bounds.size.width*0.0483)];
    WaitingMax.font = [UIFont fontWithName:@"Marker Felt" size:20];
    WaitingMax.adjustsFontSizeToFitWidth = YES;
    WaitingMax.text = @"3600";
    WaitingMax.textColor = [UIColor colorWithRed:212.0/255.0 green:202.0/255.0 blue:255.0/255.0 alpha:1];
    [self addSubview:WaitingMax];
    
    int WaitingValue = 200;
    int WaitingResult = WaitingValue*0.05;
    
    UILabel *WaitingV = [[UILabel alloc]init];
    WaitingV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.169,
                                [UIScreen mainScreen].bounds.size.width*0.2053,
                                [UIScreen mainScreen].bounds.size.width*0.0532,
                                [UIScreen mainScreen].bounds.size.width*0.0483);
    WaitingV.font = [UIFont fontWithName:@"Marker Felt" size:12];
    WaitingV.adjustsFontSizeToFitWidth = YES;
    WaitingV.text = [NSString stringWithFormat: @"%d",WaitingValue];
    WaitingV.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [self addSubview:WaitingV];
    
    
    UIView *HomeIntelligenceValueImg = [[UIView alloc]init];
    HomeIntelligenceValueImg.backgroundColor = [UIColor colorWithRed:82.0/255.0 green:131.0/255.0 blue:192.0/255.0 alpha:1];
    [HomeIntelligenceValueImg.layer setMasksToBounds:YES];
    [HomeIntelligenceValueImg.layer setCornerRadius:3];
    HomeIntelligenceValueImg.frame = CGRectMake(0,
                                                0,
                                                WaitingResult,
                                                [UIScreen mainScreen].bounds.size.width*0.0266);
    [HomeIntelligenceBackImg addSubview:HomeIntelligenceValueImg];
}

-(void)initEnergyValueImage{
    HomePhysicalBackeImage.backgroundColor = [UIColor colorWithRed:46.0/255.0 green:82.0/255.0 blue:126.0/255.0 alpha:0.5];
    HomePhysicalBackeImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.1353,
                                              [UIScreen mainScreen].bounds.size.width*0.2947,
                                              [UIScreen mainScreen].bounds.size.width*0.1208,
                                              [UIScreen mainScreen].bounds.size.width*0.0266);
    [HomePhysicalBackeImage.layer setMasksToBounds:YES];
    [HomePhysicalBackeImage.layer setCornerRadius:3];
    
    
    EnergyMax.frame =     CGRectMake([UIScreen mainScreen].bounds.size.width*0.2681,
                                     [UIScreen mainScreen].bounds.size.width*0.2826,
                                     [UIScreen mainScreen].bounds.size.width*0.0676,
                                     [UIScreen mainScreen].bounds.size.width*0.0483);
    EnergyMax.text = @"10000";
    EnergyMax.font = [UIFont fontWithName:@"Marker Felt" size:12];
        EnergyMax.adjustsFontSizeToFitWidth = YES;
    EnergyMax.textColor = [UIColor colorWithRed:212.0/255.0 green:202.0/255.0 blue:255.0/255.0 alpha:1];
    
    int PhysicalValue = [_LLMainRoleEnergyValue intValue]/200;

    EnergyV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.169,
                               [UIScreen mainScreen].bounds.size.width*0.285,
                               [UIScreen mainScreen].bounds.size.width*0.0531,
                               [UIScreen mainScreen].bounds.size.width*0.0483);
    EnergyV.font = [UIFont fontWithName:@"Marker Felt" size:12];
    EnergyV.adjustsFontSizeToFitWidth = YES;
    if (_LLMainRoleEnergyValue == nil) {
        EnergyV.text = @"0";
    }else if([_LLMainRoleEnergyValue intValue] >= 10000 ){
        EnergyV.text = @"10000";
    }else{
        EnergyV.text = _LLMainRoleEnergyValue;
    }
    
    EnergyV.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    
    
    HomePhysicalValueImage.backgroundColor = [UIColor colorWithRed:82.0/255.0 green:131.0/255.0 blue:192.0/255.0 alpha:1];
    if (_LLMainRoleEnergyValue == nil) {
        HomePhysicalValueImage.frame = CGRectMake(0, 0, 0,
                                                  [UIScreen mainScreen].bounds.size.width*0.0266);
    }else{
        HomePhysicalValueImage.frame = CGRectMake(0, 0, PhysicalValue,
                                                  [UIScreen mainScreen].bounds.size.width*0.0266);
    }

    [HomePhysicalValueImage.layer setMasksToBounds:YES];
    [HomePhysicalValueImage.layer setCornerRadius:3];
    
}

-(void)changeEnergyLabel{
    EnergyV.text = nil;
        if (_LLMainRoleEnergyValue == nil) {
    EnergyV.text = @"0";
        }else if([_LLMainRoleEnergyValue intValue] >= 10000 ){
            EnergyV.text = @"10000";
        }else{
            EnergyV.text = _LLMainRoleEnergyValue;
        }
    
//
//    int PhysicalValue = [_LLMainRoleEnergyValue intValue]/200;
//    if (_LLMainRoleEnergyValue == nil) {
//        HomePhysicalValueImage.frame = CGRectMake(0, 0, 0,
//                                                  [UIScreen mainScreen].bounds.size.width*0.0266);
//    }else{
//        HomePhysicalValueImage.frame = CGRectMake(0, 0, PhysicalValue,
//                                                  [UIScreen mainScreen].bounds.size.width*0.0266);
//    }
}

@end
