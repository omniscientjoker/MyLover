//
//  UIViewController+RSPenrose.m
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "UIViewController+RSPenrose.h"

@implementation UIViewController (RSPenrose)

- (RSPenroseViewController *)rootPenroseController {
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[RSPenroseViewController class]]) {
            return (RSPenroseViewController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}
@end
