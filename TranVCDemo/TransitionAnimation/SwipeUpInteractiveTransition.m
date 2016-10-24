//
//  SwipeUpInteractiveTransition.m
//  TranVCDemo
//
//  Created by iceMaple on 16/10/12.
//  Copyright © 2016年 yongliangP. All rights reserved.
//

#import "SwipeUpInteractiveTransition.h"

#define KWindowWidth [UIApplication sharedApplication].keyWindow.frame.size.width
#define KWindowHeight [UIApplication sharedApplication].keyWindow.frame.size.height

@interface SwipeUpInteractiveTransition ()

@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;

@end

@implementation SwipeUpInteractiveTransition


- (void)wireToViewController:(UIViewController*)viewController
{
//    UIViewAnimationCurveEaseInOut,         // slow at beginning and end
//    UIViewAnimationCurveEaseIn,            // slow at beginning
//    UIViewAnimationCurveEaseOut,           // slow at end
//    UIViewAnimationCurveLinear,
//    self.completionCurve = UIViewAnimationCurveLinear;
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];

}

- (void)prepareGestureRecognizerInView:(UIView*)view
{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

//-(CGFloat)completionSpeed
//{
//    return 1 - self.percentComplete;
//}


- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            // 1. Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
        {
            // 2. Calculate the percentage of guesture
            CGFloat fraction = (translation.y / KWindowHeight);
            //Limit it between 0 and 1
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            NSLog(@"fraction==%f",fraction);
            self.shouldComplete = (fraction > 0.5);
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            // 3. Gesture over. Check if the transition should happen or not
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled)
            {
                [self cancelInteractiveTransition];
            }
            else
            {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
