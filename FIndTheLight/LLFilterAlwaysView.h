//
//  LLFilterAlwaysView.h
//  FIndTheLight
//
//  Created by Wll on 16/12/3.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLFilterAlwaysView : UIImageView

@property (nonatomic,strong) NSString *LLfilterAlwaysString;

@property (nonatomic) int LLAlwaysFilterCount;

-(void)LLfilerAlwaysDraw;

@end
