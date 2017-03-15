//
//  HintViewPresent.m
//  FIndTheLight
//
//  Created by Wll on 16/12/7.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "HintViewPresent.h"
#import <POP/POP.h>

@implementation HintViewPresent
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromView.userInteractionEnabled = NO;
    
    UIView *dimmingView = [[UIView alloc] initWithFrame:fromView.bounds];
//    dimmingView.backgroundColor = [UIColor blackColor];
//    dimmingView.layer.opacity = 0.8;
    
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.frame = CGRectMake(0,
                              0,
//                              CGRectGetWidth(transitionContext.containerView.bounds) - 104.f,
//                              CGRectGetHeight(transitionContext.containerView.bounds) - 400.f
                              CGRectGetWidth(transitionContext.containerView.bounds)+100,
                              CGRectGetHeight(transitionContext.containerView.bounds)+100
                              );
    
    toView.center = CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);
//    toView.backgroundColor = [UIColor blackColor];
//    toView.layer.opacity = 0.8;
    [transitionContext.containerView addSubview:dimmingView];
    [transitionContext.containerView addSubview:toView];
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.toValue = @(transitionContext.containerView.center.y);
    positionAnimation.springBounciness = 0;
    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.springBounciness = 0;
//    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.2);
    opacityAnimation.duration = 0.2;
    [toView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
//    [toView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

@end
