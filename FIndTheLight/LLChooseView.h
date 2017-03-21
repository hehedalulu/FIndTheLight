//
//  LLChooseView.h
//  FIndTheLight
//
//  Created by Wll on 16/12/4.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLChooseViewDelegate <NSObject>
@optional
-(void)changeBgScene:(NSString *)SceneName;

@end

@interface LLChooseView : UIView<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UIScrollView *backgroundScrollView;
    NSMutableArray *LLFilterImageNameArray;
    NSMutableArray *LLFilterUnchosenNameArray;
    UICollectionView *LLchooseCollectView;
    
    BOOL isSelectedItem;
    NSIndexPath *SelectedIndex;
}
@property (nonatomic,strong) NSMutableArray *LLNameFilterArray;
@property (nonatomic,strong) UIButton *LLChoseViewBtn;
@property (nonatomic) NSString *LLChooseViewFiterName;
@property (nonatomic,weak) id<LLChooseViewDelegate> chooseViewdelegate;

@end
