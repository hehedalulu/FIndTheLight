//
//  LLLightBoxViewController.h
//  FIndTheLight
//
//  Created by Wll on 17/2/11.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLLightBoxDetailView.h"
#import "Masonry.h"

@interface LLLightBoxViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    LLLightBoxDetailView *detailView;
    UIImageView *CollectionBackgroundView;
}

@end
