//
//  SCViewControllerTransitionAnimator.m
//  SCFramework
//
//  Created by Angzn on 5/7/14.
//  Copyright (c) 2014 Richer VC. All rights reserved.
//

#import "SCViewControllerTransitionAnimator.h"

// 默认转场动画时间
const CGFloat kSCTransitionDurationDefault = 0.30;

@implementation SCViewControllerTransitionAnimator

#pragma mark - Init Method

- (void)defaultInit
{
    _duration = kSCTransitionDurationDefault;
    _direction = SCViewControllerTransitionDirectionHorizontal;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultInit];
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

/**
 *  @brief 转场动画持续时间
 */
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return _duration;
}

/**
 *  @brief 转场动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (_direction == SCViewControllerTransitionDirectionHorizontal &&
        _operation == SCViewControllerTransitionOperationPush) {
        [self animationHorizontalPush:transitionContext];
    } else if (_direction == SCViewControllerTransitionDirectionHorizontal &&
               _operation == SCViewControllerTransitionOperationPop) {
        [self animationHorizontalPop:transitionContext];
    } else if (_direction == SCViewControllerTransitionDirectionVertical &&
               _operation == SCViewControllerTransitionOperationPush) {
        [self animationVerticalPush:transitionContext];
    } else if (_direction == SCViewControllerTransitionDirectionVertical &&
               _operation == SCViewControllerTransitionOperationPop) {
        [self animationVerticalPop:transitionContext];
    }
}

#pragma mark - Private Method

/**
 *  @brief 横向Push动画
 */
- (void)animationHorizontalPush:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:
                              UITransitionContextToViewControllerKey];
    
    UIView *toView = toVC.view;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    toView.transform = CGAffineTransformMakeTranslation(toView.width, 0);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         toView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         BOOL cancelled = [transitionContext transitionWasCancelled];
                         [transitionContext completeTransition:!cancelled];
                     }];
}

/**
 *  @brief 横向Pop动画
 */
- (void)animationHorizontalPop:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC   = [transitionContext viewControllerForKey:
                                UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:
                                UITransitionContextFromViewControllerKey];
    
    UIView *toView   = toVC.view;
    UIView *fromView = fromVC.view;
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toView belowSubview:fromView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         fromView.transform = CGAffineTransformMakeTranslation(fromView.width, 0);
                     }
                     completion:^(BOOL finished) {
                         BOOL cancelled = [transitionContext transitionWasCancelled];
                         [transitionContext completeTransition:!cancelled];
                     }];
}

/**
 *  @brief 纵向Push动画
 */
- (void)animationVerticalPush:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:
                              UITransitionContextToViewControllerKey];
    
    UIView *toView = toVC.view;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    toView.transform = CGAffineTransformMakeTranslation(0, toView.height);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         toView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         BOOL cancelled = [transitionContext transitionWasCancelled];
                         [transitionContext completeTransition:!cancelled];
                     }];
}

/**
 *  @brief 纵向Pop动画
 */
- (void)animationVerticalPop:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC   = [transitionContext viewControllerForKey:
                                UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:
                                UITransitionContextFromViewControllerKey];
    
    UIView *toView   = toVC.view;
    UIView *fromView = fromVC.view;
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toView belowSubview:fromView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         fromView.transform = CGAffineTransformMakeTranslation(0, fromView.height);
                     }
                     completion:^(BOOL finished) {
                         BOOL cancelled = [transitionContext transitionWasCancelled];
                         [transitionContext completeTransition:!cancelled];
                     }];
}

@end
