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
    BackgroundView.frame = CGRectMake(0, 0, 180, 150);
    BackgroundView.image = [UIImage imageNamed:@"textbox_grade"];
    [self addSubview:BackgroundView];
    
    
    UIImageView *Levelimg = [[UIImageView alloc]init];
    Levelimg.image = [UIImage imageNamed:@"icon_grade"];
    Levelimg.frame = CGRectMake(15, 10, 32, 32);
    [self addSubview:Levelimg];
    
    UIImageView *SelfIcon = [[UIImageView alloc]init];
    SelfIcon.image = [UIImage imageNamed:@"icon_user"];
    SelfIcon.frame = CGRectMake(15, 42, 32, 32);
    [self addSubview:SelfIcon];

    UIImageView *WaitingBall = [[UIImageView alloc]init];
    WaitingBall.image = [UIImage imageNamed:@"icon_light"];
    WaitingBall.frame = CGRectMake(15, 75, 32, 32);
    [self addSubview:WaitingBall];
    
    
    UIImageView *Energy =  [[UIImageView alloc]init];
    Energy.image = [UIImage imageNamed:@"icon_battery"];
    Energy.frame = CGRectMake(16, 114, 37, 32);
    [self addSubview:Energy];
    

    
    UILabel *HomeUsername = [[UILabel alloc]init];
    HomeUsername.text = @"JULIA";
    HomeUsername.frame = CGRectMake(56, 50, 150, 32);
    HomeUsername.font = [UIFont fontWithName:@"Marker Felt" size:20];
//    HomeUsername.adjustsLetterSpacingToFitWidth = YES;
//    LLHomePageInformationView *llhomepageinformationView = [[LLHomePageInformationView alloc]init];
    
    [self changeWordSpaceForLabel:HomeUsername WithSpace:2];
    HomeUsername.textColor = [UIColor colorWithRed:212.0/255 green:202.0/255 blue:255.0/255 alpha:1];
    [self addSubview:HomeUsername];
    
    UILabel *HomeLevel = [[UILabel alloc]init];
    HomeLevel.text = @"LV7";
    HomeLevel.frame = CGRectMake(56, 18, 150, 32);
//    HomeLevel.adjustsLetterSpacingToFitWidth = YES;
    [self changeWordSpaceForLabel:HomeLevel WithSpace:2];
    HomeLevel.font = [UIFont fontWithName:@"Marker Felt" size:20];
    HomeLevel.textColor = [UIColor colorWithRed:212.0/255 green:202.0/255 blue:255.0/255 alpha:1];
    [self addSubview:HomeLevel];
    
    [self initWaitingBallValueImage];
    [self initEnergyValueImage];
//    [self initLevelValueImage];
    
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
    HomeIntelligenceBackImg.frame = CGRectMake(56, 89, 50, 11);
    [HomeIntelligenceBackImg.layer setMasksToBounds:YES];
    [HomeIntelligenceBackImg.layer setCornerRadius:3
     ];
    [self addSubview:HomeIntelligenceBackImg];
    
    UILabel *WaitingMax = [[UILabel alloc]initWithFrame:CGRectMake(111, 82, 28, 20)];
    WaitingMax.font = [UIFont fontWithName:@"Marker Felt" size:20];
    WaitingMax.adjustsFontSizeToFitWidth = YES;
    WaitingMax.text = @"3600";
    WaitingMax.textColor = [UIColor colorWithRed:212.0/255.0 green:202.0/255.0 blue:255.0/255.0 alpha:1];
    [self addSubview:WaitingMax];
    
    int WaitingValue = 200;
    int WaitingResult = WaitingValue*0.05;
    
    UILabel *WaitingV = [[UILabel alloc]init];
    WaitingV.frame = CGRectMake(70, 85, 22, 20);
    WaitingV.font = [UIFont fontWithName:@"Marker Felt" size:12];
    WaitingV.adjustsFontSizeToFitWidth = YES;
    WaitingV.text = [NSString stringWithFormat: @"%d",WaitingValue];
    WaitingV.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [self addSubview:WaitingV];
    
    
    UIView *HomeIntelligenceValueImg = [[UIView alloc]init];
    HomeIntelligenceValueImg.backgroundColor = [UIColor colorWithRed:82.0/255.0 green:131.0/255.0 blue:192.0/255.0 alpha:1];
    [HomeIntelligenceValueImg.layer setMasksToBounds:YES];
    [HomeIntelligenceValueImg.layer setCornerRadius:5];
    HomeIntelligenceValueImg.frame = CGRectMake(0, 0, WaitingResult, 11);
    [HomeIntelligenceBackImg addSubview:HomeIntelligenceValueImg];
}

-(void)initEnergyValueImage{
    UIView *HomePhysicalBackeImage = [[UIView alloc]init];
    HomePhysicalBackeImage.backgroundColor = [UIColor colorWithRed:46.0/255.0 green:82.0/255.0 blue:126.0/255.0 alpha:0.5];
    HomePhysicalBackeImage.frame = CGRectMake(56, 122, 50, 11);
    [HomePhysicalBackeImage.layer setMasksToBounds:YES];
    [HomePhysicalBackeImage.layer setCornerRadius:5];
    [self addSubview:HomePhysicalBackeImage];
    
    UILabel *EnergyMax = [[UILabel alloc]initWithFrame:CGRectMake(111, 117, 28, 20)];
//    EnergyMax.font = [UIFont fontWithName:@"TrebuchetMS" size:2];
    EnergyMax.text = @"10000";
    EnergyMax.font = [UIFont fontWithName:@"Marker Felt" size:12];
        EnergyMax.adjustsFontSizeToFitWidth = YES;
    EnergyMax.textColor = [UIColor colorWithRed:212.0/255.0 green:202.0/255.0 blue:255.0/255.0 alpha:1];
    [self addSubview:EnergyMax];
    
    int PhysicalValue = [_LLMainRoleEnergyValue intValue]/200;
    
    UILabel *EnergyV = [[UILabel alloc]init];
    EnergyV.frame = CGRectMake(70, 118, 22, 20);
//    EnergyV.font = [UIFont fontWithName:@"TrebuchetMS" size:2];
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
    [self addSubview:EnergyV];
    
    UIView *HomePhysicalValueImage = [[UIView alloc]init];
    HomePhysicalValueImage.backgroundColor = [UIColor colorWithRed:82.0/255.0 green:131.0/255.0 blue:192.0/255.0 alpha:1];
    if (_LLMainRoleEnergyValue == nil) {
        HomePhysicalValueImage.frame = CGRectMake(0, 0, 0, 11);
    }else{
        HomePhysicalValueImage.frame = CGRectMake(0, 0, PhysicalValue, 11);
    }

    [HomePhysicalValueImage.layer setMasksToBounds:YES];
    [HomePhysicalValueImage.layer setCornerRadius:3];
    [HomePhysicalBackeImage addSubview:HomePhysicalValueImage];
    
}

//-(void)initLevelValueImage{
//    UIView *HomeLevelBackImage = [[UIView alloc]init];
//    HomeLevelBackImage.backgroundColor = [UIColor colorWithRed:198.0/255.0 green:95.0/255.0 blue:3.0/255.0 alpha:0.5];
//    HomeLevelBackImage.frame = CGRectMake(90, 110, 50, 10);
//    [HomeLevelBackImage.layer setMasksToBounds:YES];
//    [HomeLevelBackImage.layer setCornerRadius:3];
//    [self addSubview:HomeLevelBackImage];
//    
//    int LevelValue = 20;
//    
//    UIView *HomeLevelValueImage = [[UIView alloc]init];
//    HomeLevelValueImage.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:135.0/255.0 blue:29.0/255.0 alpha:1];
//    HomeLevelValueImage.frame = CGRectMake(0, 0, LevelValue, 10);
//    [HomeLevelValueImage.layer setMasksToBounds:YES];
//    [HomeLevelValueImage.layer setCornerRadius:3];
//    [HomeLevelBackImage addSubview: HomeLevelValueImage];
//    
//}
@end
