//
//  LLHomePageInformationView.h
//  UniversityPokemon
//
//  Created by Wll on 16/11/20.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLHomePageInformationView : UIView{
    UILabel *EnergyV;
    UIView *HomePhysicalBackeImage;
    UILabel *EnergyMax;
    UIView *HomePhysicalValueImage;
}

@property(nonatomic , strong) NSString *LLHomeName;
@property(nonatomic , strong) NSString *LLHomeIntellectualValues;
@property(nonatomic , strong) NSString *LLMainRoleEnergyValue;
@property(nonatomic , strong) NSString *LLHomeLevelValues;

-(void)initEnergyValueImage;
-(void)changeEnergyLabel;
@end
