//
//  LLMatureView.m
//  FIndTheLight
//
//  Created by Wll on 16/12/18.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLMatureView.h"

@implementation LLMatureView

/*
 LLMatureImageView;
 LLMaturePpImageView;
 LLMatureThingsLabel;
 LLMaturePpThingsLabel;
 LLGradeImageView;
 LLCollectLabel;
 LLHasCollectNumber;
 LLCollectTotalNumber;
 */
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

//[UIScreen mainScreen] bounds].size.width
- (void)drawRect:(CGRect)rect {
    [self DrawMatureView];
    
    
}
-(void)DrawMatureView{
    NSLog(@"绘制");
//    self.backgroundColor = [UIColor greenColor];
//    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 380)];
//    backgroundView.backgroundColor = [UIColor clearColor];
//    [self addSubview:backgroundView];
//    [backgroundView.layer setMasksToBounds:YES];
    self.backgroundColor = [UIColor grayColor];
    
    _LLMatureImageView = [[UIImageView alloc]init];
    [_LLMatureImageView.layer setCornerRadius:8];
    _LLMatureImageView.frame = CGRectMake(40, 30, 0, 0);
    _LLMatureImageView.backgroundColor = [UIColor cyanColor];
    _LLMatureImageView.layer.masksToBounds = YES;
    [self addSubview:_LLMatureImageView];
    
    _LLGradeImageView = [[UIImageView alloc]init];
    _LLGradeImageView.frame = CGRectMake(210, 210, 0, 0);
    [_LLGradeImageView.layer setCornerRadius:8];
    _LLGradeImageView.backgroundColor = [UIColor yellowColor];
    _LLGradeImageView.layer.masksToBounds = YES;
    [self addSubview:_LLGradeImageView];
    
    _LLMatureThingsLabel = [[UILabel alloc]init];
    _LLMatureThingsLabel.frame = CGRectMake(80, 255, 0, 0);
    _LLMatureThingsLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:16];
    _LLMatureThingsLabel.adjustsFontSizeToFitWidth = YES;
    _LLMatureThingsLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    _LLMatureThingsLabel.layer.masksToBounds = YES;
    _LLMatureThingsLabel.text = @"光体名称";
    [self addSubview:_LLMatureThingsLabel];
    
    _LLMaturePpImageView = [[UIImageView alloc]init];
    _LLMaturePpImageView.frame = CGRectMake(10, 300, 0, 0);
    [_LLMaturePpImageView.layer setCornerRadius:5];
    _LLMaturePpImageView.backgroundColor = [UIColor cyanColor];
    [self addSubview:_LLMaturePpImageView];
    
    _LLMaturePpThingsLabel = [[UILabel alloc]init];
    _LLMaturePpThingsLabel.frame = CGRectMake(70, 315, 0, 0);
    _LLMaturePpThingsLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
//    _LLMaturePpThingsLabel.font = [UIFont systemFontOfSize:16];
    _LLMaturePpThingsLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:16];
    _LLMaturePpThingsLabel.text = @"光属";
    [self addSubview:_LLMaturePpThingsLabel];
    
    _LLProgressBgIMG = [[UIImageView alloc]init];
    _LLProgressBgIMG.backgroundColor = [UIColor whiteColor];
    [_LLProgressIMG.layer setCornerRadius:5];
    _LLProgressBgIMG.frame = CGRectMake(150, 320, 0, 0);
    [self addSubview:_LLProgressBgIMG];
    
    _LLProgressIMG = [[UIImageView alloc]init];
    _LLProgressIMG.backgroundColor = [UIColor grayColor];
    _LLProgressIMG.frame = CGRectMake(0, 0, 0, 0);
    [_LLProgressBgIMG addSubview:_LLProgressIMG];
    
    
    _LLHasCollectNumber = 3;
    _LLCollectTotalNumber = 5;
    
    _LLCollectLabel = [[UILabel alloc]init];
    _LLCollectLabel.frame = CGRectMake(10, 0, 0, 0);
    _LLCollectLabel.textColor = [UIColor brownColor];
    _LLCollectLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:10];
//    _LLCollectLabel.adjustsFontSizeToFitWidth = YES;
    _LLCollectLabel.text = [NSString stringWithFormat:@"收集中 %d/%d",_LLHasCollectNumber,_LLCollectTotalNumber];
    [_LLProgressBgIMG addSubview:_LLCollectLabel];
}

@end
