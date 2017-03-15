//
//  LLLightBoxDetailView.m
//  FIndTheLight
//
//  Created by Wll on 17/3/6.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLLightBoxDetailView.h"
#import "Masonry.h"

#define LightShowBoxWidth self.bounds.size.width
#define LightShowBoxHeight self.bounds.size.height
@implementation LLLightBoxDetailView

@synthesize LightName;
@synthesize LightLevel;
@synthesize LightCount;
@synthesize LLBoxSuiPianLabel1;
@synthesize LLBoxSuiPianLabel2;
@synthesize LLBoxSuiPianLabel3;
@synthesize LLBoxLightImage;
@synthesize LLBoxSuiPianImage1;
@synthesize LLBoxSuiPianImage2;
@synthesize LLBoxSuiPianImage3;
@synthesize LLBoxSuiPianFix3;



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *BackgroundView = [[UIImageView alloc]init];
        BackgroundView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        BackgroundView.image = [UIImage imageNamed:@"Light_instruction_layer.png"];
        [self addSubview:BackgroundView];
        
        
        UILabel *LightNameLabel = [[UILabel alloc]init];
        LightNameLabel.text = @"NAME 名称";
        LightNameLabel.font = [UIFont systemFontOfSize:10];
        LightNameLabel.textColor = [UIColor colorWithRed:42.0/255.0 green:94.0/255.0 blue:161.0/255.0 alpha:1];
        [self addSubview:LightNameLabel];
        [LightNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(16);
            make.left.equalTo(self).with.offset(self.frame.size.width*0.042);
            make.height.mas_equalTo(self.frame.size.height*0.1);
            make.width.mas_equalTo(self.frame.size.width*0.14);
            
        }];
        
        UILabel *LightLevelLabel = [[UILabel alloc]init];
        LightLevelLabel.text = @"RARITY 稀有度";
        LightLevelLabel.font = [UIFont systemFontOfSize:10];
        LightLevelLabel.textColor = [UIColor colorWithRed:42.0/255.0 green:94.0/255.0 blue:161.0/255.0 alpha:1];
        [self addSubview:LightLevelLabel];
        [LightLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(LightNameLabel.mas_bottom);
            make.left.equalTo(LightNameLabel);
            make.width.mas_equalTo(self.frame.size.width*0.174);
            make.height.mas_equalTo(LightNameLabel);
        }];
        
        UILabel *LightCountLabel = [[UILabel alloc]init];
        LightCountLabel.text = @"DEBRIS QUANTITY 碎片数量";
        LightCountLabel.font = [UIFont systemFontOfSize:10];
        LightCountLabel.textColor = [UIColor colorWithRed:42.0/255.0 green:94.0/255.0 blue:161.0/255.0 alpha:1];
        [self addSubview:LightCountLabel];
        [LightCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(LightLevelLabel.mas_bottom);
            make.left.equalTo(LightNameLabel);
            make.width.mas_equalTo(self.frame.size.width*0.33);
            make.height.mas_equalTo(LightNameLabel);
        }];
        
        LightName = [[UILabel alloc]init];
        LightName.text = @"灯泡";
        LightName.font = [UIFont systemFontOfSize:16];
        LightName.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        [self addSubview:LightName];
        [LightName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(LightNameLabel).offset(-2);
            make.left.equalTo(LightNameLabel.mas_right);
            make.width.mas_equalTo(self.frame.size.width*0.085);
            make.height.mas_equalTo(LightNameLabel);
        }];
        
        LightLevel = [[UILabel alloc]init];
        LightLevel.text = @"C";
        LightLevel.font = [UIFont systemFontOfSize:16];
        LightLevel.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        [self addSubview:LightLevel];
        [LightLevel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(LightLevelLabel).offset(-2);
            make.left.equalTo(LightLevelLabel.mas_right);
            make.width.mas_equalTo(self.frame.size.width*0.15);
            make.height.mas_equalTo(LightNameLabel);
        }];
        
        LightCount = [[UILabel alloc]init];
        LightCount.text = @"3片";
        LightCount.font = [UIFont systemFontOfSize:16];
        LightCount.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        [self addSubview:LightCount];
        [LightCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(LightCountLabel).offset(-2);
            make.left.equalTo(LightCountLabel.mas_right);
            make.width.mas_equalTo(LightNameLabel);
            make.height.mas_equalTo(LightNameLabel);
        }];
        
        UIImageView *divisionStride = [[UIImageView alloc]init];
        divisionStride.image = [UIImage imageNamed:@"instruction_divison.png"];
        [self addSubview:divisionStride];
        [divisionStride mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(LightShowBoxWidth*0.016);
            make.top.equalTo(LightCountLabel.mas_bottom);
            make.width.mas_equalTo(LightShowBoxWidth*0.48);
            make.height.mas_equalTo(1);
        }];
        
        LLBoxSuiPianImage1 = [[UIImageView alloc]init];
        LLBoxSuiPianImage1.image = [UIImage imageNamed:@"debris_unknown.png"];
        [self addSubview:LLBoxSuiPianImage1];
        [LLBoxSuiPianImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(LightNameLabel);
            make.top.mas_equalTo(divisionStride.mas_bottom).offset(self.frame.size.width*0.042);
            make.width.mas_equalTo(self.frame.size.width*0.0853);
            make.height.mas_equalTo(self.frame.size.width*0.0853);
        }];
        
        LLBoxSuiPianImage2 = [[UIImageView alloc]init];
        LLBoxSuiPianImage2.image = [UIImage imageNamed:@"debris_neon.png"];
        [self addSubview:LLBoxSuiPianImage2];
        [LLBoxSuiPianImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(LightNameLabel);
            make.top.mas_equalTo(LLBoxSuiPianImage1.mas_bottom).offset(self.frame.size.width*0.032);
            make.width.mas_equalTo(self.frame.size.width*0.0853);
            make.height.mas_equalTo(self.frame.size.width*0.0853);
        }];
        
        LLBoxSuiPianImage3 = [[UIImageView alloc]init];
        LLBoxSuiPianImage3.image = [UIImage imageNamed:@"debris_neon.png"];
        [self addSubview:LLBoxSuiPianImage3];
        [LLBoxSuiPianImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(LightNameLabel);
            make.top.mas_equalTo(LLBoxSuiPianImage2.mas_bottom).offset(self.frame.size.width*0.032);
            make.width.mas_equalTo(self.frame.size.width*0.0853);
            make.height.mas_equalTo(self.frame.size.width*0.0853);
        }];
        
        
        UILabel *LLBoxSuiPianFix1 = [[UILabel alloc]init];
        LLBoxSuiPianFix1.text = @"DEBRIS NO.1";
        LLBoxSuiPianFix1.textColor = [UIColor colorWithRed:42.0/255.0 green:94.0/255.0 blue:161.0/255.0 alpha:1];
        [self addSubview:LLBoxSuiPianFix1];
        [LLBoxSuiPianFix1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(LLBoxSuiPianImage1.mas_right).offset(self.frame.size.width*0.021);
            make.top.mas_equalTo(LLBoxSuiPianImage1.mas_top).offset(-2);
            make.width.mas_equalTo(self.frame.size.width*0.112);
            make.height.mas_equalTo(self.frame.size.width*0.03);
        }];
        LLBoxSuiPianFix1.adjustsFontSizeToFitWidth = YES;
        
        UILabel *LLBoxSuiPianFix2 = [[UILabel alloc]init];
        LLBoxSuiPianFix2.text = @"DEBRIS NO.2";
        LLBoxSuiPianFix2.textColor = [UIColor colorWithRed:42.0/255.0 green:94.0/255.0 blue:161.0/255.0 alpha:1];
        [self addSubview:LLBoxSuiPianFix2];
        [LLBoxSuiPianFix2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(LLBoxSuiPianImage2.mas_right).offset(self.frame.size.width*0.021);
            make.top.mas_equalTo(LLBoxSuiPianImage2.mas_top).offset(-2);
            make.width.mas_equalTo(self.frame.size.width*0.112);
            make.height.mas_equalTo(self.frame.size.width*0.03);
        }];
        LLBoxSuiPianFix2.adjustsFontSizeToFitWidth = YES;
        
        LLBoxSuiPianFix3 = [[UILabel alloc]init];
        LLBoxSuiPianFix3.text = @"DEBRIS NO.3";
        LLBoxSuiPianFix3.textColor = [UIColor colorWithRed:42.0/255.0 green:94.0/255.0 blue:161.0/255.0 alpha:1];
        [self addSubview:LLBoxSuiPianFix3];
        [LLBoxSuiPianFix3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(LLBoxSuiPianImage3.mas_right).offset(self.frame.size.width*0.021);
            make.top.mas_equalTo(LLBoxSuiPianImage3.mas_top).offset(-2);
            make.width.mas_equalTo(self.frame.size.width*0.112);
            make.height.mas_equalTo(self.frame.size.width*0.03);
        }];
        LLBoxSuiPianFix3.adjustsFontSizeToFitWidth = YES;
        
        
        LLBoxSuiPianLabel1 = [[UILabel alloc]init];
        LLBoxSuiPianLabel1.text = @"钨丝";
        LLBoxSuiPianLabel1.font = [UIFont systemFontOfSize:14];
        LLBoxSuiPianLabel1.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        [self addSubview:LLBoxSuiPianLabel1];
        [LLBoxSuiPianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(LLBoxSuiPianFix1);
            make.top.mas_equalTo(LLBoxSuiPianFix1.mas_bottom).offset(2);
            make.width.mas_equalTo(self.frame.size.width*0.2);
            make.height.mas_equalTo(self.frame.size.width*0.05);
        }];
        
        LLBoxSuiPianLabel2 = [[UILabel alloc]init];
        LLBoxSuiPianLabel2.text = @"氖气";
        LLBoxSuiPianLabel2.font = [UIFont systemFontOfSize:14];
        LLBoxSuiPianLabel2.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        [self addSubview:LLBoxSuiPianLabel2];
        [LLBoxSuiPianLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(LLBoxSuiPianFix2);
            make.top.mas_equalTo(LLBoxSuiPianFix2.mas_bottom).offset(2);
            make.width.mas_equalTo(self.frame.size.width*0.2);
            make.height.mas_equalTo(self.frame.size.width*0.05);
        }];
        
        LLBoxSuiPianLabel3 = [[UILabel alloc]init];
        LLBoxSuiPianLabel3.text = @"玻璃";
        LLBoxSuiPianLabel3.font = [UIFont systemFontOfSize:14];
        LLBoxSuiPianLabel3.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        [self addSubview:LLBoxSuiPianLabel3];
        [LLBoxSuiPianLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(LLBoxSuiPianFix3);
            make.top.mas_equalTo(LLBoxSuiPianFix3.mas_bottom).offset(2);
            make.width.mas_equalTo(self.frame.size.width*0.2);
            make.height.mas_equalTo(self.frame.size.width*0.05);
        }];
        
        
        UIImageView *LightBoxBackground = [[UIImageView alloc]init];
        LightBoxBackground.image = [UIImage imageNamed:@"instruction_mark.png"];
        [self addSubview:LightBoxBackground];
        [LightBoxBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.frame.size.width*0.09);
            make.right.equalTo(self).offset(-self.frame.size.width*0.053);
            make.width.mas_equalTo(self.frame.size.width*0.408);
            make.height.mas_equalTo(self.frame.size.width*0.408);
        }];
        
        UIImageView *LightBoxbottomStride = [[UIImageView alloc]init];
        LightBoxbottomStride.image = [UIImage imageNamed:@"instruction_divison.png"];
        [self addSubview:LightBoxbottomStride];
        [LightBoxbottomStride mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(LightBoxBackground.mas_bottom).offset(self.frame.size.width*0.032);
            make.right.equalTo(self).offset(-self.frame.size.width*0.016);
            make.width.mas_equalTo(self.frame.size.width*0.432);
            make.height.mas_equalTo(1);
        }];
        
        LLBoxLightImage = [[UIImageView alloc]init];
        LLBoxLightImage.image = [UIImage imageNamed:@"optical.png"];
        [self addSubview:LLBoxLightImage];
        [LLBoxLightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.frame.size.width*0.09);
            make.right.equalTo(self).offset(-self.frame.size.width*0.053);
            make.width.mas_equalTo(self.frame.size.width*0.408);
            make.height.mas_equalTo(self.frame.size.width*0.408);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    // 一定要调用super的方法
    [super layoutSubviews];

}
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

}


@end
