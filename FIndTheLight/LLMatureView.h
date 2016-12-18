//
//  LLMatureView.h
//  FIndTheLight
//
//  Created by Wll on 16/12/18.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLMatureView : UIView{
}
-(void)DrawMatureView;

@property (strong,nonatomic) UILabel *LLlightValue;

@property (strong,nonatomic) UIImageView *LLMatureImageView;

@property (strong,nonatomic) UIImageView *LLMaturePpImageView;

@property (strong,nonatomic) UILabel *LLMatureThingsLabel;

@property (strong,nonatomic) UILabel *LLMaturePpThingsLabel;

@property (strong,nonatomic) UIImageView *LLGradeImageView;

@property (strong,nonatomic) UILabel *LLCollectLabel;

@property (nonatomic) int LLHasCollectNumber;

@property (nonatomic) int LLCollectTotalNumber;

@property (strong,nonatomic) UIImageView *LLProgressBgIMG;

@property (strong,nonatomic) UIImageView *LLProgressIMG;

@end
