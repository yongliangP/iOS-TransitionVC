//
//  PushAnimation.h
//  TranVCDemo
//
//  Created by iceMaple on 2016/10/19.
//  Copyright © 2016年 yongliangP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,TransitionAnimType)
{
    TransitionAnimTypePush,
    TransitionAnimTypePop
};

@interface PushAnimation : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(TransitionAnimType)type;


@end
