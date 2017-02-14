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
    BackDisplaygroundView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    BackDisplaygroundView.image = [UIImage imageNamed:@"textbox_location"];
    BackDisplaygroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:BackDisplaygroundView];
    
    
    _LLHomeDisplayLabel = [[UILabel alloc]init];
    _LLHomeDisplayLabel.frame = CGRectMake(10, 5, self.bounds.size.width*0.8547, self.bounds.size.height*0.333);
//    _LLHomeDisplayLabel.frame.size = CGSizeMake(150, 15)
//    _LLHomeDisplayLabel.center.x = self.center.x;
    _LLHomeDisplayLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:16];
    _LLHomeDisplayLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    _LLHomeDisplayLabel.text = @"";
    _LLHomeDisplayLabel.textAlignment = NSTextAlignmentCenter;
    _LLHomeDisplayLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_LLHomeDisplayLabel];
    
    UILabel *LocationLabel = [[UILabel alloc]init];
    LocationLabel.frame = CGRectMake(0,self.bounds.size.height/2 , self.bounds.size.width, self.bounds.size.height/2);
    LocationLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:16];
    LocationLabel.adjustsFontSizeToFitWidth = YES;
    LocationLabel.text = @"华中科技大学";
    LocationLabel.textAlignment = NSTextAlignmentCenter;
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
