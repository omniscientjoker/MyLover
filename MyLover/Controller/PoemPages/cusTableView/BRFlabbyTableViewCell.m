//
//  BRFlabbyTableViewCell.m
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "BRFlabbyTableViewCell.h"
#define HIGHLIGHT_Y_CONTROL_POINT   25
#pragma mark - BRFlabbyTableViewCell

@implementation BRFlabbyTableViewCell
@synthesize nameLab, timeLab, authLab, backImgView;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self commitInit];
    }
    return self;
}
- (void)commitInit
{

    backImgView = [[UIImageView alloc] init];
    backImgView.clipsToBounds=YES;
    backImgView.contentMode=UIViewContentModeScaleAspectFill;
    [self addSubview:backImgView];
    [backImgView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self);
         make.top.equalTo(self);
         make.right.equalTo(self);
         make.bottom.equalTo(self);
     }];


    nameLab = [self normalLabel];
    nameLab.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:20.0f];
    [self addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self).with.offset(20);
         make.centerY.equalTo(self.mas_centerY);
         make.height.mas_equalTo(@30);
     }];

    authLab = [self normalLabel];
    authLab.font = [UIFont fontWithName:@"AppleSDGothicNeo" size:16.0f];
    [self addSubview:authLab];
    [authLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self).with.offset(-20);
         make.centerY.equalTo(self.mas_centerY).with.offset(-40);
         make.height.mas_equalTo(@20);
     }];

    timeLab = [self normalLabel];
    timeLab.font = [UIFont fontWithName:@"BodoniSvtyTwoITCTT-Book" size:16.0f];
    [self addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(self).with.offset(-20);
         make.centerY.equalTo(self.mas_centerY).with.offset(40);
         make.height.mas_equalTo(@20);
     }];
}
-(UILabel *)normalLabel
{
    UILabel * normalLabel = [[UILabel alloc] init];
    normalLabel.backgroundColor = [UIColor clearColor];
    normalLabel.textColor       = [[UIColor blackColor] colorWithAlphaComponent:0.9f];
    normalLabel.textAlignment   = NSTextAlignmentCenter;
    normalLabel.font            = [UIFont systemFontOfSize:16.0f];
    return normalLabel;
}
- (void)enableFlabby
{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setSelectedBackgroundView:nil];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setNeedsDisplay];
}

- (void)setFlabby:(BOOL)isFlabby
{
    _isFlabby = isFlabby;
    if (isFlabby)
    {
        [self enableFlabby];
    }
}

- (void)setFlabbyColor:(UIColor *)flabbyColor
{
    _flabbyColor = flabbyColor;
    [self enableFlabby];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (_flabbyHighlightState == BRFlabbyHighlightStateCellTouched || !_isFlabby || (fabs(_verticalVelocity) < 1.0 && _flabbyHighlightState == BRFlabbyHighlightStateNone))
    {
        CGContextSetFillColorWithColor(ctx, [_flabbyColor CGColor]);
        CGContextFillRect(ctx, rect);
    }
    else
    {
        CGFloat x = rect.origin.x;
        CGFloat y = rect.origin.y;
        CGFloat w = rect.size.width;
        CGFloat h = rect.size.height;
        CGFloat controlYOffset = _verticalVelocity*2>(h/2)?(h/2):_verticalVelocity*2;
        CGContextSetFillColorWithColor(ctx, [_flabbyOverlapColor CGColor]);
        CGContextFillRect(ctx, rect);
        CGFloat controlPointX1, controlPointX2, controlPointX3, controlPointX4, controlPointY1, controlPointY2;
        switch (_flabbyHighlightState)
        {
            case BRFlabbyHighlightStateCellAboveTouched:
                controlPointX1 = _touchXLocationInCell + x;
                controlPointX2 = _touchXLocationInCell + x;
                controlPointX3 = x + (w/2 + x) + (w - (w/2 + x))/2;
                controlPointX4 = (x + (w/2 + x))/2;
                controlPointY1 = HIGHLIGHT_Y_CONTROL_POINT;
                controlPointY2 = y+h+controlYOffset;
                CGContextSetFillColorWithColor(ctx, [_flabbyColorAbove CGColor]);
                CGContextFillRect(ctx, CGRectMake(x, y, w, h/2));
                break;
            case BRFlabbyHighlightStateCellBelowTouched:
                controlPointX1 = (x + (w/2 + x))/2;
                controlPointX2 = x + (w/2 + x) + (w - (w/2 + x))/2;
                controlPointX3 = _touchXLocationInCell + x;
                controlPointX4 = _touchXLocationInCell + x;
                controlPointY1 = controlYOffset;
                controlPointY2 = y+h-HIGHLIGHT_Y_CONTROL_POINT;
                CGContextSetFillColorWithColor(ctx, [_flabbyColorBelow CGColor]);
                CGContextFillRect(ctx, CGRectMake(x, y+h/2, w, h/2));
                break;
            default:
                controlPointX1 = (x + (w/2 + x))/2;
                controlPointX2 = x + (w/2 + x) + (w - (w/2 + x))/2;
                controlPointX3 = controlPointX2;
                controlPointX4 = controlPointX1;
                controlPointY1 = y+controlYOffset;
                controlPointY2 = y+h+controlYOffset;
                break;
        }
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, x, y);
        CGPathAddCurveToPoint(path, nil, controlPointX1, controlPointY1, controlPointX2, controlPointY1, x+w, y);
        CGPathAddLineToPoint(path, nil, x+w, y+h);
        CGPathAddCurveToPoint(path, nil, controlPointX3, controlPointY2, controlPointX4, controlPointY2, x, y+h);
        CGPathCloseSubpath(path);
        CGContextAddPath(ctx, path);
        CGContextSetFillColorWithColor(ctx, [_flabbyColor CGColor]);
        CGContextFillPath(ctx);
        CGPathRelease(path);
    }
}
@end
