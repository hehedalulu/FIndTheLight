//
//  LLModelView.h
//  FIndTheLight
//
//  Created by Wll on 17/2/13.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLLocalModel.h"
#import "LLARModel.h"

@interface LLModelView : UIView{
    UIImageView *LLModelImg;
    LLLocalModel *localmodel;
    LLARModel *arModel;
}

@property (nonatomic) UIImageView *LLLocalModel;
@property (nonatomic) UILabel *LLLocalLightValue;
@property (nonatomic) UILabel *LLLocalName;
@property (nonatomic) UIImageView *LLLocalModelLevel;
@property (nonatomic) UIImageView *LLLocalWaitingBall;
@property (nonatomic,assign) int modelViewType;

@end
