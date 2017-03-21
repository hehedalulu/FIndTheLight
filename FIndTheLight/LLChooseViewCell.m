//
//  LLChooseViewCell.m
//  FIndTheLight
//
//  Created by Wll on 17/3/18.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLChooseViewCell.h"

@implementation LLChooseViewCell
@synthesize FilterNameLabel;
@synthesize ChooseCellSelectImage;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    _LLchoseFilterimg = [[UIImageView alloc]init];
    _LLchoseFilterimg.frame = CGRectMake(0,
                                         0,
                                         self.bounds.size.width,
                                         self.bounds.size.height*0.85);
    _LLchoseFilterimg.image = [UIImage imageNamed:@"default_chosen@2x.png"];
    _LLchoseFilterimg.userInteractionEnabled = YES;
//    _LLchoseFilterimg.backgroundColor = [UIColor clearColor];
    //        UIImageView *btnBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
    //                                                                               self.bounds.size.width*0.213,
    //                                                                               self.bounds.size.width*0.27)];
    //        btnBackImg.image = [UIImage imageNamed:[LLFilterImageNameArray objectAtIndex:i]];
    //        [_LLchoseFilterBtn addSubview:btnBackImg];
    [self addSubview:_LLchoseFilterimg];
    
    ChooseCellSelectImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chosen"]];
    ChooseCellSelectImage.frame = CGRectMake(self.bounds.size.width*0.28,
                             self.bounds.size.height*0.4,
                             self.bounds.size.width*0.43,
                             self.bounds.size.width*0.34);
    ChooseCellSelectImage.userInteractionEnabled = YES;
    ChooseCellSelectImage.hidden = YES;
    [self addSubview:ChooseCellSelectImage];
    
    FilterNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                               self.bounds.size.height*0.85,
                                                               self.bounds.size.width,
                                                               self.bounds.size.height*0.15)];
    FilterNameLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    FilterNameLabel.text = @"test";
    FilterNameLabel.font = [UIFont systemFontOfSize:15];
    FilterNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:FilterNameLabel];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
@end
