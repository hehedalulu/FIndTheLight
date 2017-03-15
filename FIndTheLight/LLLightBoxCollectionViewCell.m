//
//  LLLightBoxCollectionViewCell.m
//  FIndTheLight
//
//  Created by Wll on 17/3/9.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLLightBoxCollectionViewCell.h"

@implementation LLLightBoxCollectionViewCell
@synthesize LLBoxCellImage;
@synthesize LLBoxCellLabel;

-(void)awakeFromNib {
    [super awakeFromNib];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    LLBoxCellImage = [[UIImageView alloc]init];
    LLBoxCellImage.image = [UIImage imageNamed:@"optical_layer_unknown.png"];
    [self addSubview:LLBoxCellImage];
    [LLBoxCellImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(self.bounds.size.width);
        make.height.mas_equalTo(self.bounds.size.width);
    }];
    
    LLBoxCellLabel = [[UILabel alloc]init];
    LLBoxCellLabel.text = @"光体";
    LLBoxCellLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:102.0/255.0 blue:173.0/255.0 alpha:1];
    LLBoxCellLabel.font = [UIFont systemFontOfSize:14];
    LLBoxCellLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:LLBoxCellLabel];
    [LLBoxCellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(LLBoxCellImage.mas_bottom);
        make.width.equalTo(LLBoxCellImage);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width*0.1);
    }];
    
    
    return self;
}

@end
