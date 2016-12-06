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
    BackgroundView.image = [UIImage imageNamed:@"playerinfo_textbox"];
    [self addSubview:BackgroundView];
    
    
    UIImageView *SelfIcon = [[UIImageView alloc]init];
    SelfIcon.image = [UIImage imageNamed:@"icon_me"];
    SelfIcon.frame = CGRectMake(15,3, 30, 30);
    [self addSubview:SelfIcon];

    UIImageView *Intelligence = [[UIImageView alloc]init];
    Intelligence.image = [UIImage imageNamed:@"icon_heart"];
    Intelligence.frame = CGRectMake(15, 40, 30, 30);
    [self addSubview:Intelligence];
    
    
    UIImageView *Physical =  [[UIImageView alloc]init];
    Physical.image = [UIImage imageNamed:@"icon_lamp"];
    Physical.frame = CGRectMake(15, 70, 30, 30);
    [self addSubview:Physical];
    
    UIImageView *Levelimg = [[UIImageView alloc]init];
    Levelimg.image = [UIImage imageNamed:@"icon_grade"];
    Levelimg.frame = CGRectMake(15, 100, 30, 30);
    [self addSubview:Levelimg];
    
    UILabel *HomeUsername = [[UILabel alloc]init];
    HomeUsername.font = [UIFont systemFontOfSize:20];
    HomeUsername.text = @"JULIA";
    HomeUsername.frame = CGRectMake(60, 3, 100, 30);
    HomeUsername.textColor = [UIColor orangeColor];
    [self addSubview:HomeUsername];
    
    UILabel *HomeLevel = [[UILabel alloc]init];
    HomeLevel.font = [UIFont systemFontOfSize:12];
    HomeLevel.text = @"LEVEL";
    HomeLevel.frame = CGRectMake(50, 110, 50, 10);
    HomeLevel.textColor = [UIColor whiteColor];
    [self addSubview:HomeLevel];
    
    [self initIntelligenceValueImage];
    [self initPhysicalValueImage];
    [self initLevelValueImage];
    
}

-(void)initIntelligenceValueImage{
    UIView *HomeIntelligenceBackImg = [[UIView alloc]init];
    HomeIntelligenceBackImg.backgroundColor = [UIColor colorWithRed:198.0/255.0 green:95.0/255.0 blue:3.0/255.0 alpha:0.5];
    HomeIntelligenceBackImg.frame = CGRectMake(60, 50, 80, 10);
    [HomeIntelligenceBackImg.layer setMasksToBounds:YES];
    [HomeIntelligenceBackImg.layer setCornerRadius:3];
    [self addSubview:HomeIntelligenceBackImg];
    
    int IntelligenceValue = 40;
    
    UIView *HomeIntelligenceValueImg = [[UIView alloc]init];
    HomeIntelligenceValueImg.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:135.0/255.0 blue:29.0/255.0 alpha:1];
    [HomeIntelligenceValueImg.layer setMasksToBounds:YES];
    [HomeIntelligenceValueImg.layer setCornerRadius:3];
    HomeIntelligenceValueImg.frame = CGRectMake(0, 0, IntelligenceValue, 10);
    [HomeIntelligenceBackImg addSubview:HomeIntelligenceValueImg];
}

-(void)initPhysicalValueImage{
    UIView *HomePhysicalBackeImage = [[UIView alloc]init];
    HomePhysicalBackeImage.backgroundColor = [UIColor colorWithRed:198.0/255.0 green:95.0/255.0 blue:3.0/255.0 alpha:0.5];
    HomePhysicalBackeImage.frame = CGRectMake(60, 80, 80, 10);
    [HomePhysicalBackeImage.layer setMasksToBounds:YES];
    [HomePhysicalBackeImage.layer setCornerRadius:3];
    [self addSubview:HomePhysicalBackeImage];
    
    int PhysicalValue = 50;
    
    UIView *HomePhysicalValueImage = [[UIView alloc]init];
    HomePhysicalValueImage.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:135.0/255.0 blue:29.0/255.0 alpha:1];
    HomePhysicalValueImage.frame = CGRectMake(0, 0, PhysicalValue, 10);
    [HomePhysicalValueImage.layer setMasksToBounds:YES];
    [HomePhysicalValueImage.layer setCornerRadius:3];
    [HomePhysicalBackeImage addSubview:HomePhysicalValueImage];
    
}

-(void)initLevelValueImage{
    UIView *HomeLevelBackImage = [[UIView alloc]init];
    HomeLevelBackImage.backgroundColor = [UIColor colorWithRed:198.0/255.0 green:95.0/255.0 blue:3.0/255.0 alpha:0.5];
    HomeLevelBackImage.frame = CGRectMake(90, 110, 50, 10);
    [HomeLevelBackImage.layer setMasksToBounds:YES];
    [HomeLevelBackImage.layer setCornerRadius:3];
    [self addSubview:HomeLevelBackImage];
    
    int LevelValue = 20;
    
    UIView *HomeLevelValueImage = [[UIView alloc]init];
    HomeLevelValueImage.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:135.0/255.0 blue:29.0/255.0 alpha:1];
    HomeLevelValueImage.frame = CGRectMake(0, 0, LevelValue, 10);
    [HomeLevelValueImage.layer setMasksToBounds:YES];
    [HomeLevelValueImage.layer setCornerRadius:3];
    [HomeLevelBackImage addSubview: HomeLevelValueImage];
    
}
@end
