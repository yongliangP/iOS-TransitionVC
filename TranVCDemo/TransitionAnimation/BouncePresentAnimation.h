//
//  BouncePresentAnimation.h
//  TranVCDemo
//
//  Created by iceMaple on 16/10/11.
//  Copyright © 2016年 yongliangP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,TransitionType)
{
    TransitionTypePresent,
    TransitionTypeDissmiss
};

@interface BouncePresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(TransitionType)type;

- (instancetype)initWithTransitionType:(TransitionType)type;

@end
