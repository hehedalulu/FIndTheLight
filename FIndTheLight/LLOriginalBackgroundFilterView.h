//
//  LLOriginalBackgroundFilterView.h
//  FIndTheLight
//
//  Created by Wll on 16/12/28.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLOriginalBackgroundFilterView : UIImageView{
    NSMutableArray *ImageArray;
}

@property (nonatomic,strong) NSString *LLOriginalfilterString;

@property (nonatomic) int LLOriginalFilterCount;


-(void)LLInitOriginalFilter;


@end
