//
//  PushAnimation.m
//  TranVCDemo
//
//  Created by iceMaple on 2016/10/19.
//  Copyright © 2016年 yongliangP. All rights reserved.
//

#import "PushAnimation.h"

#define KWindowWidth [UIApplication sharedApplication].keyWindow.frame.size.width
#define KWindowHeight [UIApplication sharedApplication].keyWindow.frame.size.height
@interface PushAnimation ()<CAAnimationDelegate>

@property(nonatomic,strong) id<UIViewControllerContextTransitioning>transitionContext;

@property (nonatomic, assign) TransitionAnimType type;

@end

@implementation PushAnimation


+ (instancetype)transitionWithTransitionType:(TransitionAnimType)type
{
    return [[self alloc] initWithTransitionType:type];

}

- (instancetype)initWithTransitionType:(TransitionAnimType)type{
    self = [super init];
    if (self)
    {
        _type = type;
    }
    return self;
}


//pop动画
-(void)transitionAnimTypePopWithTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    //路径处理
    CGRect originRect = CGRectMake(KWindowWidth-50, KWindowHeight-50, 50, 50);
    UIBezierPath *maskStartPath = [UIBezierPath bezierPathWithOvalInRect:originRect];
    UIBezierPath *maskEndPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(originRect, -2000, -2000)];
    //创建一个CAShapeLayer来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskAnimation.fromValue = (id)maskStartPath.CGPath;
    maskAnimation.toValue = (id)maskEndPath.CGPath;
    maskAnimation.duration = [self transitionDuration:transitionContext];
    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskAnimation.fillMode = kCAFillModeForwards;
    maskAnimation.removedOnCompletion = NO;
    maskAnimation.delegate = self;
    [maskLayer addAnimation:maskAnimation forKey:@"Path"];

}

//push动画
-(void)transitionAnimTypePushWithTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    //路径处理
    CGRect originRect = CGRectMake(0, 0, 50, 50);
    UIBezierPath *maskStartPath = [UIBezierPath bezierPathWithOvalInRect:originRect];
    UIBezierPath *maskEndPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(originRect, -2000, -2000)];
    //创建一个CAShapeLayer来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskAnimation.fromValue = (id)maskStartPath.CGPath;
    maskAnimation.toValue = (id)maskEndPath.CGPath;
    maskAnimation.duration = [self transitionDuration:transitionContext];
    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskAnimation.fillMode = kCAFillModeForwards;
    maskAnimation.removedOnCompletion = NO;
    maskAnimation.delegate = self;
    [maskLayer addAnimation:maskAnimation forKey:@"Path"];
    
}


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    switch (self.type)
    {
        case TransitionAnimTypePop:
            [self transitionAnimTypePopWithTransitionContext:transitionContext];
            break;
        case TransitionAnimTypePush:
             [self transitionAnimTypePushWithTransitionContext:transitionContext];
            break;
        default:
            break;
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //完成动画
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    //去除mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}


@end
