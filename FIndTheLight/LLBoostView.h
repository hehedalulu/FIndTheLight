//
//  LLBoostView.h
//  FIndTheLight
//
//  Created by Wll on 16/12/21.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLGetNowTime.h"
@interface LLBoostView : UIView{
    
}
@property (nonatomic) int LLNowEnergy;
@property (nonatomic) long int LLMatureNeedEnergy;
@property (nonatomic,strong) UIButton *LLTapBoostbtn;
@property (nonatomic,strong) UILabel *LLBoostContextLabel;
@property (nonatomic,strong) UIImageView *LLBoostcontentView;
@end
