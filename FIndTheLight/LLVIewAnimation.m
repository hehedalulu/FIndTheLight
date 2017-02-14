//
//  LLVIewAnimation.m
//  FIndTheLight
//
//  Created by Wll on 17/2/13.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLVIewAnimation.h"

@implementation LLVIewAnimation
//本地光体刚出现时的动画
-(void)LocalModelAppearAnimationWithImgView:(UIImageView *)imageView{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100,
                                                                [UIScreen mainScreen].bounds.size.height/2-120,
                                                                160,
                                                                200)];
    PopMatureView.springBounciness = 10.0;
    PopMatureView.springSpeed      = 5.0;
   [imageView pop_addAnimation:PopMatureView forKey:@"POPModelView"];
    [PopMatureView setCompletionBlock:^(POPAnimation *popname, BOOL hasfinish) {
        [self LocalModelChange:imageView];
    }];
}
//本地光体模型消失时的动画
-(void)LocalModelDisAppearAnimationWithImgView:(UIImageView *)imageView{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
    PopMatureView.toValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    PopMatureView.springBounciness = 2.0;
    PopMatureView.springSpeed      = 5.0;
    [imageView pop_addAnimation:PopMatureView forKey:@"POPModelView"];
//    [PopMatureView setCompletionBlock:^(POPAnimation *popname, BOOL hasfinish) {
//        [self LocalModelChange:imageView];
//    }];
}

//本地光体沿着xy轴弹一弹的动画
-(void)LocalModelChange:(UIImageView *)imageView{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewSize];
//    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100,
//                                                                [UIScreen mainScreen].bounds.size.height/2-120,
//                                                                160,
//                                                                200)];
    PopMatureView.toValue = [NSValue valueWithCGSize:CGSizeMake(imageView.bounds.size.width*0.9, imageView.bounds.size.height)];
    PopMatureView.springBounciness = 10.0;
    PopMatureView.springSpeed      = 2.0;
//    PopMatureView.repeatCount = 3;
    [imageView pop_addAnimation:PopMatureView forKey:@"POPModelViewX"];
    [PopMatureView setCompletionBlock:^(POPAnimation *popname, BOOL hasfinish) {
        [self LocalModelChangeRecover:imageView];
    }];
}


-(void)LocalModelChangeRecover:(UIImageView *)imageView{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewSize];

    PopMatureView.toValue = [NSValue valueWithCGSize:CGSizeMake(imageView.bounds.size.width/0.9, imageView.bounds.size.height)];
    PopMatureView.springBounciness = 10.0;
    PopMatureView.springSpeed      = 2.0;
//    PopMatureView.repeatCount = 3;
    [imageView pop_addAnimation:PopMatureView forKey:@"POPModelViewX"];
}


//本地光体等级Level出现动画
-(void)LocalModelLevelAppearAnimationWithImge:(UIImageView *)imageView{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2+20,
                                                                [UIScreen mainScreen].bounds.size.height/2+80,
                                                                40,
                                                                40)];
    PopMatureView.springBounciness = 10.0;
    PopMatureView.springSpeed      = 5.0;
    [imageView pop_addAnimation:PopMatureView forKey:@"POPModelLevelView"];
}
//本地光体等级level消失动画
-(void)LocalModelLevelDisAppearAnimationWithImge:(UIImageView *)imageView{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                                [UIScreen mainScreen].bounds.size.height/2,
                                                                0,
                                                                0)];
    PopMatureView.springBounciness = 10.0;
    PopMatureView.springSpeed      = 5.0;
    [imageView pop_addAnimation:PopMatureView forKey:@"POPModelLevelView"];
}

//本地光体名字出现动画
-(void)LocalModelNameAppearAnimationWithLabel:(UILabel *)label{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2-30,
                                                                [UIScreen mainScreen].bounds.size.height/2+80,
                                                                40,
                                                                40)];
    PopMatureView.springBounciness = 10.0;
    PopMatureView.springSpeed      = 5.0;
    [label pop_addAnimation:PopMatureView forKey:@"POPLabelLevelView"];
}
//本地光体名字消失动画
-(void)LocalModelNameDisAppearAnimationWithLabel:(UILabel *)label{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2-30,
                                                                [UIScreen mainScreen].bounds.size.height/2+80,
                                                                0,
                                                                0)];
    PopMatureView.springBounciness = 10.0;
    PopMatureView.springSpeed      = 5.0;
    [label pop_addAnimation:PopMatureView forKey:@"POPLabelLevelView"];
}

//本地光体生成的光球产生
//-(void)LocalModelWaitingAppearAnimationWithImg:(UIImageView *)imageView{
//    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
//    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
//    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2-,
//                                                                [UIScreen mainScreen].bounds.size.height/2-80,
//                                                                160,
//                                                                200)];
//    PopMatureView.springBounciness = 10.0;
//    PopMatureView.springSpeed      = 5.0;
//    [imageView pop_addAnimation:PopMatureView forKey:@"POPModelWaitingView"];
//    [PopMatureView setCompletionBlock:^(POPAnimation *popname, BOOL hasfinish) {
//        [self test:imageView];
//    }];
//    
//}
-(void)LightBallMove:(UIImageView*)imageView{
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake([UIScreen mainScreen].bounds.size.width*0.4+15,
                                         [UIScreen mainScreen].bounds.size.width*0.6+15)];
    [bezierPath addCurveToPoint: CGPointMake(285.32, 121.4) controlPoint1: CGPointMake(189.5, 257.5) controlPoint2: CGPointMake(193.91, 139.49)];
    [bezierPath addCurveToPoint: CGPointMake(287.52, 121.4) controlPoint1: CGPointMake(306.87, 117.13) controlPoint2: CGPointMake(287.52, 121.4)];
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 4.0f;
    pathAnimation.path = bezierPath.CGPath;  // 加入贝塞尔路径
    pathAnimation.calculationMode = kCAAnimationLinear;
    [imageView.layer addAnimation:pathAnimation forKey:@"movingAnimation"];
    
    POPBasicAnimation *small = [POPBasicAnimation animation];
    small.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    small.toValue = @(0.0);
    small.duration = 3.0;
    [imageView pop_addAnimation:small forKey:@"POPsmall"];
    
    
//    imageView.frame = CGRectMake(292-15, 124-15, 30, 30);
    
}

-(void)LightValueMove:(UILabel *)label{
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake([UIScreen mainScreen].bounds.size.width*0.4+15,
                                         [UIScreen mainScreen].bounds.size.width*0.6+15)];
    [bezierPath addCurveToPoint: CGPointMake(285.32, 121.4) controlPoint1: CGPointMake(189.5, 257.5) controlPoint2: CGPointMake(193.91, 139.49)];
    [bezierPath addCurveToPoint: CGPointMake(287.52, 121.4) controlPoint1: CGPointMake(306.87, 117.13) controlPoint2: CGPointMake(287.52, 121.4)];
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 4.0f;
    pathAnimation.path = bezierPath.CGPath;  // 加入贝塞尔路径
    pathAnimation.calculationMode = kCAAnimationLinear;
    [label.layer addAnimation:pathAnimation forKey:@"movingAnimation"];
    

    label.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:17];
    label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25);
    [label sizeToFit];
    
    [UIView animateWithDuration:0.5 animations:^{
        label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0);
    } completion:^(BOOL finished) {
        label.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:17];
        label.transform = CGAffineTransformScale(label.transform, 1.0, 1.0);
        [label sizeToFit];
        
    }];
    
    
    POPBasicAnimation *BecomeLight = [POPBasicAnimation animation];
    BecomeLight.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    BecomeLight.fromValue = @(0.0);
    BecomeLight.toValue = @(1.0);
    BecomeLight.duration = 1.0;
    [label pop_addAnimation:BecomeLight forKey:@"POPLight"];
    [BecomeLight setCompletionBlock:^(POPAnimation *popname, BOOL hasfinish) {
        POPBasicAnimation *BecomeDark = [POPBasicAnimation animation];
        BecomeDark.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
        BecomeDark.fromValue = @(1.0);
        BecomeDark.toValue = @(0.0);
        BecomeDark.duration = 2.0;
        [label pop_addAnimation:BecomeDark forKey:@"POPbecameDark"];
    }];
    

}


//碎片的动画--------------------------------------------------------------------------------------------------

-(void)LocalSuiPianAppearWithImg:(UIImageView *)imageView{
    POPBasicAnimation *PopMatureView = [POPBasicAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2-55,
                                                                [UIScreen mainScreen].bounds.size.height/2-110,
                                                                100,
                                                                100)];
    [imageView pop_addAnimation:PopMatureView forKey:@"POPModelView"];
}

-(void)LocalSuiPianNameAppearWithLabel:(UILabel *)label{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2-90,
                                                                [UIScreen mainScreen].bounds.size.height/2,
                                                                160,
                                                                30)];
    PopMatureView.springBounciness = 3.0;
    PopMatureView.springSpeed      = 5.0;
    [label pop_addAnimation:PopMatureView forKey:@"POPModelView"];
}
-(void)LocalSuiPianCountWithLabel:(UILabel *)label{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2-90,
                                                                [UIScreen mainScreen].bounds.size.height/2+40,
                                                                160,
                                                                30)];
    PopMatureView.springBounciness = 3.0;
    PopMatureView.springSpeed      = 5.0;
    [label pop_addAnimation:PopMatureView forKey:@"POPModelView"];
}

-(void)LocalSuiPianDisAppearWithImg:(UIImageView *)imageView{
    POPBasicAnimation *PopMatureView = [POPBasicAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                                [UIScreen mainScreen].bounds.size.height/2,
                                                                0,
                                                                0)];
    [imageView pop_addAnimation:PopMatureView forKey:@"POPModelView"];
}

-(void)LocalSuiPianNameDisAppearWithLabel:(UILabel *)label{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                                [UIScreen mainScreen].bounds.size.height/2,
                                                                0,
                                                                0)];
    PopMatureView.springBounciness = 3.0;
    PopMatureView.springSpeed      = 5.0;
    [label pop_addAnimation:PopMatureView forKey:@"POPModelView"];
}

-(void)LocalSuiPianCountDisWithLabel:(UILabel *)label{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2,
                                                                [UIScreen mainScreen].bounds.size.height/2,
                                                                0,
                                                                0)];
    PopMatureView.springBounciness = 3.0;
    PopMatureView.springSpeed      = 5.0;
    [label pop_addAnimation:PopMatureView forKey:@"POPModelView"];
}


@end
