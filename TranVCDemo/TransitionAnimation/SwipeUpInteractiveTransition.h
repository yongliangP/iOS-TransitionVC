//
//  SwipeUpInteractiveTransition.h
//  TranVCDemo
//
//  Created by iceMaple on 16/10/12.
//  Copyright © 2016年 yongliangP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition 

@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController*)viewController;

@end
