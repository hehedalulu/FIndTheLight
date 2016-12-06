//
//  LLFilterView.m
//  FIndTheLight
//
//  Created by Wll on 16/12/3.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLFilterView.h"

@implementation LLFilterView

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/
-(void)LLfilerDraw{
//
//    [self performSelector:@selector(test) withObject:nil afterDelay:0.0];
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(FilterLighting) userInfo:nil repeats:YES];
//    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(FilterLightingBackgroundRain) userInfo:nil repeats:YES];
    
}

-(void)FilterLighting{
    [self animationWithName:@"FilterLighting" andImageCount:50];
}
-(void)FilterLightingBackgroundRain{
    [self animationWithName:@"FilterLightingBackgroundRain" andImageCount:2];
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
        NSString *imageName = [NSString stringWithFormat:@"%@-%d@2x",name,i];
//        NSLog(@"%@",imageName);
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
//        NSLog(@"%@",path);
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        

//        UIImage *image = [UIImage imageNamed:imageName];
//        NSLog(@"%@",image);

        
        //      3、把图片添加到数组中
        [images addObject:image];
    }
    //  把image赋值给执行动画所需要图片
    self.animationImages = images;
    //  设置动画执行的时间
    
    self.animationDuration = imageCount * 0.03;
    //  设置动画执行的重复次数
    self.animationRepeatCount = 1;
    //  开始动画
    [self startAnimating];
    // 1.创建SystemSoundID,根据音效文件来生成
    SystemSoundID soundID = 0;
    
    // 2.根据音效文件,来生成SystemSoundID
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"7005.mp3" withExtension:nil];
    CFURLRef urlRef = (__bridge CFURLRef)(url);
    AudioServicesCreateSystemSoundID(urlRef, &soundID);
    NSLog(@"bofangyinxiao");
    // 播放音效
     AudioServicesPlaySystemSound(soundID);
    
    //有震动效果
//    AudioServicesPlayAlertSound(self.soundID);
    //动画播送完之后清除内存
    
    [self performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:1.6];
}
@end
