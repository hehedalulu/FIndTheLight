//
//  LLSuiPianVIew.h
//  FIndTheLight
//
//  Created by Wll on 17/2/14.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LLARSuiPianModel.h"
//#import "LLLocalSuiPian.h"
#import "LLSuiPian.h"
#import "LLLocalModelRandomSet.h"
#import "LLARModelRandomSet.h"

@interface LLSuiPianVIew : UIView{
//    LLLocalSuiPian *SuiPian;
//    LLARSuiPianModel *arSuiPian;
}

@property (nonatomic) UIImageView *LLSuiPianImg;

@property (nonatomic) int LLSuiPianNumber;

@property (nonatomic) UILabel *LLSuipianName;

@property (nonatomic) UILabel *LLSuiPianTotalLabel;

@property (nonatomic,assign) int LLSuiPianType;

@property (nonatomic,copy) NSString *LLSuiPianViewBelongModel;


@end
