//
//  LLHomePageDisplayView.m
//  UniversityPokemon
//
//  Created by Wll on 16/11/19.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLHomePageDisplayView.h"
#import "Masonry.h"

@implementation LLHomePageDisplayView

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *BackDisplaygroundView = [[UIImageView alloc]init];
    BackDisplaygroundView.frame = CGRectMake(0, 0, 150, 80);
    BackDisplaygroundView.image = [UIImage imageNamed:@"Btn_textbox"];
    BackDisplaygroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:BackDisplaygroundView];
    
    
    _LLHomeDisplayLabel = [[UILabel alloc]init];
    _LLHomeDisplayLabel.frame = CGRectMake(25, 10, 120, 30);
    _LLHomeDisplayLabel.font = [UIFont systemFontOfSize:26];
    _LLHomeDisplayLabel.textColor = [UIColor whiteColor];
    _LLHomeDisplayLabel.text = @"未知";
    [self addSubview:_LLHomeDisplayLabel];
    
    
    UILabel *LocationLabel = [[UILabel alloc]init];
    LocationLabel.frame = CGRectMake(25, 50, 120, 30);
    LocationLabel.font = [UIFont systemFontOfSize:18];
    LocationLabel.text = @"华中科技大学";
    LocationLabel.textColor = [UIColor colorWithRed:253.0/255.0 green:229.0/255.0 blue:279.0/255.0 alpha:1];
    [self addSubview:LocationLabel];
    
//    [_LLHomeDisplayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self).centerOffset(CGPointMake(0, 10));
//    }];
//    
//    [LocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self).centerOffset(CGPointMake(0, 20));
//    }];
}

@end
