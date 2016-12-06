//
//  LLFilterBackgroundView.m
//  FIndTheLight
//
//  Created by Wll on 16/12/3.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLFilterBackgroundView.h"

@implementation LLFilterBackgroundView


// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//    self.image = image;
}


-(void)setImage{
    self.image = [UIImage imageNamed:@"FilterLighting_bg_img"];
    self.alpha = _LLFilteralapa;

}
-(void)setLLFilterBackgroundViewName:(NSString *)name{
    self.LLFilterBackgroundViewName = name;
}

//-(void)setLLFilterAlpha:(CGFloat)alpha{
//    self.LLFilteralapa = alpha;
//}

@end
