//
//  LLPunchStepsCollectionViewCell.h
//  FIndTheLight
//
//  Created by Wll on 17/1/22.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLPunchStepsCollectionViewCell : UICollectionViewCell

@property (nonatomic) UILabel *LLPunchWeekLabel;

@property (nonatomic) UILabel *LLPunchDayLabel;

@property (nonatomic) UILabel *LLPunchStepsLabel;

@property (nonatomic) UIImageView *LLPunchAward;

@property (nonatomic) BOOL LLhasOver10000;

@end
