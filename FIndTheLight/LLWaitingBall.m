//
//  LLWaitingBall.m
//  FIndTheLight
//
//  Created by Wll on 16/12/14.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLWaitingBall.h"
#import <POP/POP.h>

@implementation LLWaitingBall

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)LLBallAlwaysDraw{
//    self.contentMode =  UIViewContentModeCenter;
    [self animationWithName:@"waitingBall" andImageCount:140];

}



- (void)animationWithName:(NSString *) name andImageCount:(int) imageCount
{
    //  如果当前正在执行动画，就不要在执行其他动画了
    if (self.isAnimating) {
        //        [self performSelector:@selector(test) withObject:nil afterDelay:5.0];
        return;
    }
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:imageCount];
    for (int i = 1; i <= imageCount; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%@-%d",name,i];
 
        //       NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        //        NSLog(@"%@",path);
        //        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        UIImage *image = [UIImage imageNamed:imageName];
        //        NSLog(@"%@",image);
        //      3、把图片添加到数组中
        [images addObject:image];
    }
    //  把image赋值给执行动画所需要图片
    self.animationImages = images;
    //  设置动画执行的时间
    
    self.animationDuration = imageCount * 0.05;
    //  设置动画执行的重复次数
    self.animationRepeatCount = 0;
    //  开始动画
    [self startAnimating];
    //动画播送完之后清除内存
    
    //    [self performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:0.17];
}

@end
