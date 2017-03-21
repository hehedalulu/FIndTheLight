//
//  LLMixView.m
//  FIndTheLight
//
//  Created by Wll on 17/3/21.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLMixView.h"

@implementation LLMixView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,
                                                                                    self.bounds.size.width,
                                                                                    self.bounds.size.height)];
        backgroundImage.image = [UIImage imageNamed:@"layer.png"];
        backgroundImage.clipsToBounds = YES;
        backgroundImage.backgroundColor = [UIColor clearColor];
        [self addSubview:backgroundImage];
    }
    return self;
}

- (void)layoutSubviews {
    // 一定要调用super的方法
    [super layoutSubviews];
    
}

@end
