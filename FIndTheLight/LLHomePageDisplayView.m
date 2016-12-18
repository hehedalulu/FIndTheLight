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
    BackDisplaygroundView.frame = CGRectMake(0, 0, 117, 60);
    BackDisplaygroundView.image = [UIImage imageNamed:@"textbox_location"];
    BackDisplaygroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:BackDisplaygroundView];
    
    
    _LLHomeDisplayLabel = [[UILabel alloc]init];
    _LLHomeDisplayLabel.frame = CGRectMake(18, 10, 100, 20);
    _LLHomeDisplayLabel.font = [UIFont fontWithName:@"Consolas" size:16];
    _LLHomeDisplayLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    _LLHomeDisplayLabel.text = @"定位中…";
    _LLHomeDisplayLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_LLHomeDisplayLabel];
    
    
    UILabel *LocationLabel = [[UILabel alloc]init];
    LocationLabel.frame = CGRectMake(15, 35, 100, 20);
    LocationLabel.font = [UIFont fontWithName:@"Consolas" size:16];
    LocationLabel.adjustsFontSizeToFitWidth = YES;
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
