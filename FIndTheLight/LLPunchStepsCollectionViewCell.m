//
//  LLPunchStepsCollectionViewCell.m
//  FIndTheLight
//
//  Created by Wll on 17/1/22.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLPunchStepsCollectionViewCell.h"

@implementation LLPunchStepsCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:38.0/255.0 blue:59.0/255.0 alpha:1];
    
    
    _LLPunchDayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height/3, self.bounds.size.width, self.bounds.size.height/3)];
    _LLPunchDayLabel.textAlignment = NSTextAlignmentCenter;
    _LLPunchDayLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    _LLPunchDayLabel.text = @"999";
    _LLPunchDayLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
    [self.contentView  addSubview:_LLPunchDayLabel];
    
    _LLPunchStepsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height*2/3, self.bounds.size.width, self.bounds.size.height/3)];
    _LLPunchStepsLabel.textAlignment = NSTextAlignmentCenter;
    _LLPunchStepsLabel.text = @"0步";
    _LLPunchStepsLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    _LLPunchStepsLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
    [self.contentView addSubview:_LLPunchStepsLabel];
    
    [self  addButton];
    
    _LLPunchAward = [[UIImageView alloc]init];
//    if (_LLhasOver10000) {
//        NSLog(@"超过10000");
        _LLPunchAward.frame = CGRectMake(0, self.bounds.size.height/8, self.bounds.size.width/2, self.bounds.size.height/2);
        _LLPunchAward.image = [UIImage imageNamed:@"jiangzhang.png"];
        _LLPunchAward.hidden = YES;
        [self addSubview:_LLPunchAward];
    
//    }else{
//        [Award removeFromSuperview];
//        NSLog(@"没有10000");
//    }
    
    return self;
}
//- (void) checkR {
//
//    [[self viewWithTag:1] removeFromSuperview];
//    NSLog(@"听说你这个家伙要把我给组装一下？？？？");
//
//    [self  addButton];
//
//}
- (void)addButton{
    _LLPunchWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height/3)];
    _LLPunchWeekLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    _LLPunchWeekLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
    _LLPunchWeekLabel.textAlignment = NSTextAlignmentCenter;
//    _LLPunchWeekLabel.tag = 1;
    _LLPunchWeekLabel.text = @".";
    [self.contentView addSubview:_LLPunchWeekLabel];
}
@end
