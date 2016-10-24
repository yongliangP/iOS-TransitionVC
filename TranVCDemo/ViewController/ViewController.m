//
//  ViewController.m
//  TranVCDemo
//
//  Created by iceMaple on 16/10/11.
//  Copyright © 2016年 yongliangP. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "BouncePresentAnimation.h"
#import "SwipeUpInteractiveTransition.h"
#import "PushViewController.h"
#import "PushAnimation.h"
@interface ViewController ()<ModalViewControllerDelegate,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) BouncePresentAnimation *presentAnimation;
@property (nonatomic, strong) SwipeUpInteractiveTransition *transitionController;
@property (nonatomic, strong) PushAnimation *pushAnimation;

@end

@implementation ViewController


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.presentAnimation = [[BouncePresentAnimation alloc]init];
        self.transitionController = [[SwipeUpInteractiveTransition alloc] init];
        self.pushAnimation = [[PushAnimation alloc] init];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (IBAction)presentButtonClick:(UIButton *)sender
{
    ModalViewController *mvc =  [[ModalViewController alloc] init];
    mvc.transitioningDelegate = self;
    mvc.delegate = self;
    [self.transitionController wireToViewController:mvc];
    [self presentViewController:mvc animated:YES completion:nil];
    
}


- (IBAction)pushButtonClick:(UIButton *)sender
{
    PushViewController *mvc =  [[PushViewController alloc] init];
    [self.navigationController pushViewController:mvc animated:YES];

}


-(void)modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush)
    {

        return [PushAnimation transitionWithTransitionType:
                TransitionAnimTypePush];
    }
    else if (operation == UINavigationControllerOperationPop)
    {
        return [PushAnimation transitionWithTransitionType:
                        TransitionAnimTypePop];

    }
    //返回nil则使用默认的动画效果
    return nil;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [BouncePresentAnimation transitionWithTransitionType:TransitionTypePresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [BouncePresentAnimation transitionWithTransitionType:TransitionTypeDissmiss];
}


-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.transitionController.interacting ? self.transitionController : nil;
}



@end
