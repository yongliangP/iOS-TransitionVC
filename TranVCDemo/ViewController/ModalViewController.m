//
//  ModalViewController.m
//  TranVCDemo
//
//  Created by iceMaple on 16/10/11.
//  Copyright © 2016年 yongliangP. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}
- (IBAction)dismissButtonClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(modalViewControllerDidClickedDismissButton:)]) {
        [self.delegate modalViewControllerDidClickedDismissButton:self];
    }
}


@end
