//
//  PenroseView.h
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RSPenroseView : UIView
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *topColor;
@property (nonatomic, strong) UIColor *rightColor;
@property (nonatomic, strong) UIColor *leftColor;

@property (nonatomic) int currentSide;

@property (nonatomic) BOOL canRotate;

@property (nonatomic) BOOL colorSelectedSide;
@property (nonatomic, strong) UIColor *selectColor;


-(void)selectSide:(int)side;
@end
