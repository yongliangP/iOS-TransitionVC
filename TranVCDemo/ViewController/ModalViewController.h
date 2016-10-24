//
//  ModalViewController.h
//  TranVCDemo
//
//  Created by iceMaple on 16/10/11.
//  Copyright © 2016年 yongliangP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModalViewController;
@protocol ModalViewControllerDelegate <NSObject>

-(void) modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController;

@end

@interface ModalViewController : UIViewController

@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;

@end
