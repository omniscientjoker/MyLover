//
//  CusButtonView.h
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CusButtonViewSelectedBlock)(void);

@interface CusButtonView : UIView<UIGestureRecognizerDelegate>
- (void)addMenuItemWithTitle:(NSString*)title andIcon:(UIImage*)icon andSelectedBlock:(CusButtonViewSelectedBlock)block;
- (void)show;
@end
