//
//  LLMixTableViewCell.h
//  FIndTheLight
//
//  Created by Wll on 17/2/18.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCAlertView.h"
//#import "LLFilterModel.h"
@interface LLMixTableViewCell : UITableViewCell{
//    LLFilterModel *filterModel;

    int SuiPianNeed1;
    int SuiPianHad1;
    
    int SuiPianNeed2;
    int SuiPianHad2;
    
    int SuiPianNeed3;
    int SuiPianHad3;
    JCAlertView *customAlert;
}

@property (nonatomic) UIImageView *LLMixCellBgV;

@property (nonatomic) int SuiPiancount;
@property (nonatomic) UIImageView *LLMixIcon;
@property (nonatomic) UIButton *LLMixBtn;
@property (nonatomic) UILabel *LLMixFilterName;


//settle未点击
@property (nonatomic) UIImageView *LLMixSuiPianImage1;
@property (nonatomic) UILabel *LLMixSuiPianLabel1;

@property (nonatomic) UIImageView *LLMixSuiPianImage2;
@property (nonatomic) UILabel *LLMixSuiPianLabel2;

@property (nonatomic) UIImageView *LLMixSuiPianImage3;
@property (nonatomic) UILabel *LLMixSuiPianLabel3;

//
@property (nonatomic) UIImageView *LLMixSuiPianProgressBgV1;
@property (nonatomic) int SuiPianProgress1;
@property (nonatomic) int SuiPianNeedProg1;
@property (nonatomic) int SuiPianStoreCount1;
@property UILabel *JinduLabel1;

@property (nonatomic) UIImageView *LLMixSuiPianProgressBgV2;
@property (nonatomic) int SuiPianProgress2;
@property (nonatomic) int SuiPianNeedProg2;
@property (nonatomic) int SuiPianStoreCount2;
@property UILabel *JinduLabel2;

@property (nonatomic) UIImageView *LLMixSuiPianProgressBgV3;
@property (nonatomic) int SuiPianProgress3;
@property (nonatomic) int SuiPianNeedProg3;
@property (nonatomic) int SuiPianStoreCount3;
@property UILabel *JinduLabel3;

@property (nonatomic) UIImageView *LLMixFilterProgressImg;

@property (nonatomic) UILabel *LLMixFilterProgress;
@property (assign) int LLMixFilterProgressPercent;
-(void)removeView;
-(void)initNewView;

@end
