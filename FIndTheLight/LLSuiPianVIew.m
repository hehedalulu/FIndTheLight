//
//  LLSuiPianVIew.m
//  FIndTheLight
//
//  Created by Wll on 17/2/14.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLSuiPianVIew.h"
#import "LLLocalSuiPian.h"

@implementation LLSuiPianVIew


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    LLLocalSuiPian *SuiPian = [[LLLocalSuiPian alloc]init];
    [SuiPian RandomSetLocalSuiPian];
    _LLSuiPianImg = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                                 [UIScreen mainScreen].bounds.size.width/2, 0, 0)];
//    _LLSuiPianImg.image = [UIImage imageNamed:@"suipian.png"];
    _LLSuiPianImg.image = SuiPian.LLLocalSuiPianImage;
    [self addSubview:_LLSuiPianImg];
    
    _LLSuipianName = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                              [UIScreen mainScreen].bounds.size.width/2, 0, 0)];
//    _LLSuipianName.text = @"碎片";
    _LLSuipianName.text = SuiPian.LLLocalSuiPianNameString;
    _LLSuipianName.font = [UIFont boldSystemFontOfSize:28];
    _LLSuipianName.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    _LLSuipianName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_LLSuipianName];
    _LLSuiPianTotalLabel= [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                                   [UIScreen mainScreen].bounds.size.width/2, 0, 0)];
//    _LLSuiPianTotalLabel.text = @"库存 3 个";
    _LLSuiPianTotalLabel.text = SuiPian.LLLocalSuiPianCount;
    _LLSuiPianTotalLabel.font = [UIFont systemFontOfSize:18];
    _LLSuiPianTotalLabel.textColor = [UIColor colorWithRed:123.0/255.0 green:168.0/255.0 blue:239.0/255.0 alpha:1];
    _LLSuiPianTotalLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_LLSuiPianTotalLabel];
}


@end
