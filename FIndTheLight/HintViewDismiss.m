//
//  HintViewDismiss.m
//  FIndTheLight
//
//  Created by Wll on 16/12/7.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "HintViewDismiss.h"
#import <POP/POP.h>
@implementation HintViewDismiss
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    toVC.view.userInteractionEnabled = YES;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    __block UIView *dimmingView;
    [transitionContext.containerView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if (view.layer.opacity < 1.f) {
            dimmingView = view;
            *stop = YES;
        }
    }];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.duration = 0.1;
//    fromVC.view.alpha = 0;
    
    POPSpringAnimation *offscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    offscreenAnimation.toValue = @(-[UIScreen mainScreen].bounds.size.height);
//    offscreenAnimation.springSpeed = 10;
    offscreenAnimation.springBounciness = 0;
    [offscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    [fromVC.view.layer pop_addAnimation:offscreenAnimation forKey:@"offscreenAnimation"];
    [fromVC.view.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

@end
