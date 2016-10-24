//
//  BouncePresentAnimation.m
//  TranVCDemo
//
//  Created by iceMaple on 16/10/11.
//  Copyright © 2016年 yongliangP. All rights reserved.
//

#import "BouncePresentAnimation.h"


@interface BouncePresentAnimation ()

@property (nonatomic, assign) TransitionType type;

@end

@implementation BouncePresentAnimation


+ (instancetype)transitionWithTransitionType:(TransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(TransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8f;
}


//实现present动画逻辑代码
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 1. Get controllers from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    //fromVC.view.hidden = YES;

    UIView * screenSnapShotView = [fromVC.view snapshotViewAfterScreenUpdates:YES];

    // 2. Set init frame for toVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);

    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];

    [containerView insertSubview:screenSnapShotView aboveSubview:fromVC.view];

    [containerView addSubview:toVC.view];

    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                         toVC.view.frame = finalFrame;
                     } completion:^(BOOL finished) {
                         // 5. Tell context that we completed.
                         [transitionContext completeTransition:YES];
                     }];

}
//实现dismiss动画逻辑代码
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    // 1. Get controllers from transition context
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 2. Set init frame for fromVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height);
    
    // 3. Add target view to the container, and move it to back.
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.type)
    {
        case TransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case TransitionTypeDissmiss:
            [self dismissAnimation:transitionContext];
            break;
 
        default:
            break;
    }

}





@end
