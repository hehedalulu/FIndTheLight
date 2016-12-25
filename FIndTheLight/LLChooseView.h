//
//  LLChooseView.h
//  FIndTheLight
//
//  Created by Wll on 16/12/4.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLChooseView : UIView<UIScrollViewDelegate>
//@property(nonatomic,strong) UISlider *LLsilderchange;
//- (CGFloat)filterchange:(UISlider *) slider;
{
    UIScrollView *backgroundScrollView;
}
@property (nonatomic,strong) NSMutableArray *LLNameFilterArray;
@property (nonatomic,strong) NSMutableArray *LLFilterImageNameArray;
@property (nonatomic,strong) UIButton *LLChoseViewBtn;
@end
