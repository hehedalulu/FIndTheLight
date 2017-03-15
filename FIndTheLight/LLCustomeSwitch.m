//
//  LLCustomeSwitch.m
//  FIndTheLight
//
//  Created by Wll on 17/2/19.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLCustomeSwitch.h"

@implementation LLCustomeSwitch

- (instancetype)initWithFrame:(CGRect)frame {
    NSAssert(NO, @"请使用 -initWithOnImage:(UIImage *)onImage offImage:(UIImage *)offImage frame:(CGRect)frame 初始化CLSwitch");
    return nil;
}

- (instancetype)initWithOnImage:(UIImage *)onImage offImage:(UIImage *)offImage frame:(CGRect)frame{
    NSAssert(onImage&&offImage, @"onImage & offImage 不能为空");
    frame.size = onImage.size;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _onImage = onImage;
        _offImage = offImage;
        [self addTarget:self action:@selector(switchClicked) forControlEvents:UIControlEventTouchUpInside];
        self.isOn = NO;
    }
    return self;
}

- (void)switchClicked {
    self.isOn = !self.SwitchisOn;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setIsOn:(BOOL)isOn {
    _SwitchisOn = isOn;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
    animation.fromValue = self.layer.contents;
    animation.toValue = (id)(_SwitchisOn ? _onImage.CGImage: _offImage.CGImage);
    animation.duration = .3;
    [self.layer addAnimation: animation forKey: @"animation"];
    
    self.layer.contents = (id)(_SwitchisOn ? _onImage.CGImage: _offImage.CGImage);
}

- (void)setFrame:(CGRect)frame {
//    if (_onImage) {
//        frame.size = _onImage.size;
//        
//    }
//    super.frame = frame;

    super.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.75,
                             [UIScreen mainScreen].bounds.size.width*0.0305,
                             [UIScreen mainScreen].bounds.size.width*0.1744,
                             [UIScreen mainScreen].bounds.size.width*0.049);
}

- (CGSize)sizeThatFits:(CGSize)size {
    return _onImage.size;
}


@end
