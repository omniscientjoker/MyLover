//
//  BRFlabbyTableViewCell.h
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BRFlabbyHighlightState)
{
    BRFlabbyHighlightStateNone,
    BRFlabbyHighlightStateCellAboveTouched,
    BRFlabbyHighlightStateCellBelowTouched,
    BRFlabbyHighlightStateCellTouched
};
@interface BRFlabbyTableViewCell : UITableViewCell
#pragma mark 属性
@property (assign, nonatomic, setter = setFlabby:)BOOL              isFlabby;
@property (assign, nonatomic, setter = setLongPressAnimated:)BOOL   longPressIsAnimated;
@property (assign, nonatomic)BRFlabbyHighlightState  flabbyHighlightState;
@property (assign, nonatomic)CGFloat                 touchXLocationInCell;
@property (assign, nonatomic)CGFloat                 verticalVelocity;
@property (copy, nonatomic)UIColor                   * flabbyColorAbove;
@property (copy, nonatomic)UIColor                   * flabbyColorBelow;
@property (copy, nonatomic)UIColor                   * flabbyOverlapColor;
@property (copy, nonatomic)UIColor                   * flabbyColor;
#pragma mark UI元素
@property (strong, nonatomic)UILabel                 * nameLab;
@property (strong, nonatomic)UILabel                 * timeLab;
@property (strong, nonatomic)UILabel                 * authLab;
@property (strong, nonatomic)UIImageView             * backImgView;
@end