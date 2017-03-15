//
//  LLCustomeSwitch.h
//  FIndTheLight
//
//  Created by Wll on 17/2/19.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLCustomeSwitch : UIControl
//事件类型  UIControlEventValueChanged
@property (nonatomic,assign)BOOL SwitchisOn;
@property(nonatomic,strong)UIImage *onImage;
@property(nonatomic,strong)UIImage *offImage;

//默认初始化方法, onImage 和 offImage 是必选参数不能为 nil,  frame.size 为无效值 ,size 根据图片size设置大小
- (instancetype)initWithOnImage:(UIImage *)onImage offImage:(UIImage *)offImage frame:(CGRect)frame;

@end
