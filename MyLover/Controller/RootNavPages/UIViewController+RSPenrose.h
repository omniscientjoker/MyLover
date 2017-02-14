//
//  UIViewController+RSPenrose.h
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPenroseViewController.h"

@class RSPenroseViewController;

@interface UIViewController (RSPenrose)

@property (nonatomic, weak, readonly) RSPenroseViewController *rootPenroseController;

@end
