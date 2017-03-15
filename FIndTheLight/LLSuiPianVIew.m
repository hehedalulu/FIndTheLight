//
//  LLSuiPianVIew.m
//  FIndTheLight
//
//  Created by Wll on 17/2/14.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLSuiPianVIew.h"

@implementation LLSuiPianVIew


// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect {
    
    

    _LLSuiPianImg = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                                 [UIScreen mainScreen].bounds.size.width/2, 0, 0)];
//    _LLSuiPianImg.image = [UIImage imageNamed:@"suipian.png"];
    
    
    
    _LLSuipianName = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                              [UIScreen mainScreen].bounds.size.width/2, 0, 0)];
//    _LLSuipianName.text = @"碎片";
    
    _LLSuipianName.font = [UIFont boldSystemFontOfSize:28];
    _LLSuipianName.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    _LLSuipianName.textAlignment = NSTextAlignmentCenter;
    
    _LLSuiPianTotalLabel= [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                                   [UIScreen mainScreen].bounds.size.width/2, 0, 0)];
//    _LLSuiPianTotalLabel.text = @"库存 3 个";
    _LLSuiPianTotalLabel.font = [UIFont systemFontOfSize:18];
    _LLSuiPianTotalLabel.textColor = [UIColor colorWithRed:123.0/255.0 green:168.0/255.0 blue:239.0/255.0 alpha:1];
    _LLSuiPianTotalLabel.textAlignment = NSTextAlignmentCenter;
    
    
    if (self.LLSuiPianType == 0) {//本地光体
        LLLocalModelRandomSet *randomset = [[LLLocalModelRandomSet alloc]init];
        //传进model的名字
        LLLocalSuiPian *localsuipain = [randomset LLLocalRandomSetSuiPianWithModelName:self.LLSuiPianViewBelongModel];
        _LLSuiPianImg.image = [UIImage imageNamed:localsuipain.LLLocalSuiPianImageName];
        _LLSuipianName.text = localsuipain.LLLocalSuiPianNameString;
        NSLog(@"测试碎片的名字%@",_LLSuipianName.text);
        _LLSuiPianTotalLabel.text = @"库存 3 个";
    }else{
        LLARModelRandomSet *randomset = [[LLARModelRandomSet alloc]init];
        LLARSuiPianModel *armodel = [randomset LLARRandomSetSuiPianWithModelName:self.LLSuiPianViewBelongModel];
        _LLSuiPianImg.image = [UIImage imageNamed:armodel.LLLARSuiPianImageName];
        _LLSuipianName.text = armodel.LLARSuiPianNameString;
        _LLSuiPianTotalLabel.text = @"库存 3 个";
        
    }
    [self addSubview:_LLSuiPianImg];
    [self addSubview:_LLSuipianName];
    [self addSubview:_LLSuiPianTotalLabel];
    
}


@end
