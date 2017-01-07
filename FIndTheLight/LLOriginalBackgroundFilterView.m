//
//  LLOriginalBackgroundFilterView.m
//  FIndTheLight
//
//  Created by Wll on 16/12/28.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLOriginalBackgroundFilterView.h"

@implementation LLOriginalBackgroundFilterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)LLInitOriginalFilter{
    [self FirstinitArraywithName:_LLOriginalfilterString andImageCount:_LLOriginalFilterCount];
    
    [self performSelector:@selector(test) withObject:nil afterDelay:0.5];

}

-(void)test{
        [self animationWithName:_LLOriginalfilterString andImageCount:_LLOriginalFilterCount];
}
- (void)animationWithName:(NSString *) name andImageCount:(int) imageCount
{
    //  如果当前正在执行动画，就不要在执行其他动画了
    if (self.isAnimating) {
        //        [self performSelector:@selector(test) withObject:nil afterDelay:5.0];
        return;
    }
    
    
    //  把image赋值给执行动画所需要图片
    self.animationImages = ImageArray;
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

-(void)FirstinitArraywithName:(NSString *)name andImageCount:(int)imageCount{
    //    NSLog(@"读内存");
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        dispatch_sync(concurrentQueue, ^{
            ImageArray =  [NSMutableArray arrayWithCapacity:imageCount];
            for (int i = 1; i <= imageCount; i++) {
                NSString *imageName = [NSString stringWithFormat:@"%@%d.png",name,i];
                //                NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
                //        NSLog(@"%@",path);
                UIImage *image = [UIImage imageNamed:imageName];
//                NSLog(@"%@",imageName);
                [ImageArray addObject:image];
            }
            
        });
    });
}


@end
