//
//  LLFilterAlwaysView.m
//  FIndTheLight
//
//  Created by Wll on 16/12/3.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLFilterAlwaysView.h"

@implementation LLFilterAlwaysView

-(void)LLfilerAlwaysDraw{
    [self animationWithName:_LLfilterAlwaysString andImageCount:_LLAlwaysFilterCount];
}

- (void)animationWithName:(NSString *) name andImageCount:(int) imageCount
{
    //  如果当前正在执行动画，就不要在执行其他动画了
    if (self.isAnimating) {
        //        [self performSelector:@selector(test) withObject:nil afterDelay:5.0];
        return;
    }
        
        
//    NSMutableArray *images = [NSMutableArray arrayWithCapacity:imageCount];
//    
//    LLinitImagesArray *llintImagesArray = [[LLinitImagesArray alloc]init];
//    //_LLloadImageType = 0为imagedName加载 1为contentsoffile加载
//    _LLloadImageType = 0;
//    if (_LLloadImageType == 0) {
//        NSMutableArray *tempimages = [llintImagesArray LLinitImagesArrayByNamed:name WithCount:imageCount];
//        [images addObjectsFromArray:tempimages];
//    }else{
//        NSMutableArray *tempimages = [llintImagesArray LLinitImagesArrayByContentsFile:name WithCount:imageCount];
//        [images addObjectsFromArray:tempimages];
//    }

    //  把image赋值给执行动画所需要图片
    self.animationImages = _ImagesArray1;
    //  设置动画执行的时间
    
    self.animationDuration = imageCount * 0.1;
    //  设置动画执行的重复次数
    self.animationRepeatCount = 0;
    //  开始动画
    [self startAnimating];
    
    NSLog(@"end");
    //动画播送完之后清除内存
    
//    [self performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:0.17];
}


@end
