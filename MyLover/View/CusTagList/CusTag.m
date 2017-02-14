//
//  CusTag.m
//  MyLover
//
//  Created by joker on 15/12/18.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "CusTag.h"
#define tagFontSize         12.0f
#define tagFontType         @"Helvetica-Light"
#define tagMargin           5.0f
#define tagHeight           25.0f
#define tagCornerRadius     3.0f
#define tagCloseButton      7.0f

@implementation CusTagList
- (id)initWithFrame:(CGRect)frame TypeEdit:(BOOL)type
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        self.tags = [NSMutableArray array];
        self.TypeEdit = type;
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    int n = 0;
    float x = 0.0f;
    float y = 0.0f;
    float buttonW = 0.0f;
    for (id v in [self subviews])
    {
        if ([v isKindOfClass:[CusTag class]])
        {
            [v removeFromSuperview];
        }
    }
    if (self.TypeEdit == YES)
    {
//        self.addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        [self.addBtn addTarget:self action:@selector(AddNewTagButton:) forControlEvents:UIControlEventTouchUpInside];
//        [self.addBtn setFrame:CGRectMake(x+5, y, 25, 25)];
//        [self addSubview:self.addBtn];
//        buttonW = 30.0f;
    }
    for (CusTag *tag in self.tags)
    {
        if (x + [tag getTagSize].width + tagMargin > self.frame.size.width)
        {
            n = 0;
            x = 0;
            y += [tag getTagSize].height + tagMargin;
        }
        else
        {
            x += (n ? tagMargin : 0.0f);
        }
        [tag setFrame:CGRectMake(x+buttonW, y, [tag getTagSize].width, [tag getTagSize].height)];
        [self addSubview:tag];
        x += [tag getTagSize].width;
        n++;
    }
    CGRect r = [self frame];
    r.size.height = y + tagHeight;
    [self setFrame:r];
}
- (CusTag *)generateTagWithLabel:(NSString *)tTitle withImage:(NSString *)tImage
{
    CusTag *tag = [[CusTag alloc] initWithFrame:CGRectZero];
    [tag setDelegate:self.delegate];
    [tag setTImage:[UIImage imageNamed:tImage]];
    [tag setTTitle:tTitle];
    [self.tags addObject:tag];
    return tag;
}
- (void)addTag:(NSString *)tTitle withImage:(NSString *)tImage
{
    [self generateTagWithLabel:tTitle withImage:tImage];
    [self setNeedsDisplay];
}
- (void)addTag:(NSString *)tTitle
     withImage:(NSString *)tImage
withLabelColor:(UIColor *)labelColor
withBackgroundColor:(UIColor *)backgroundColor
withCloseButtonColor:(UIColor *)closeColor
{
    CusTag *tag = [self generateTagWithLabel:tTitle withImage:tImage];
    if (labelColor) [tag setTLabelColor:labelColor];
    if (backgroundColor) [tag setTBackgroundColor:backgroundColor];
    if (closeColor) [tag setTCloseButtonColor:closeColor];
    [self setNeedsDisplay];
}
- (void)addTags:(NSArray *)tags
{
    for (NSDictionary *tag in tags)
    {
        [self addTag:[tag objectForKey:@"title"] withImage:[tag objectForKey:@"image"]];
    }
}
- (void)removeTag:(CusTag *)tag
{
    [self.tags removeObject:tag];
    [self setNeedsDisplay];
}
- (void)removeAllTag
{
    for (id t in [NSArray arrayWithArray:[self tags]])
    {
        [self removeTag:t];
    }
}
- (void)AddNewTagButton:(id)sender
{
    if (self.listDelegate && [self.listDelegate respondsToSelector:@selector(tagShouldBeAdd:)])
    {
        [self.listDelegate performSelector:@selector(tagShouldBeAdd:) withObject:self];
    }
}
@end

@implementation CusTag
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.tBackgroundColor = [UIColor colorWithRed:0.204 green:0.588 blue:0.855 alpha:1.000];
        self.tLabelColor = [UIColor whiteColor];
        self.tCloseButtonColor = [UIColor colorWithRed:0.710 green:0.867 blue:0.953 alpha:1.000];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        [[self layer] setCornerRadius:tagCornerRadius];
        [[self layer] setMasksToBounds:YES];
    }
    return self;
}
- (CGSize)getTagSize
{
    CGSize tSize = [self.tTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize]}];
    return CGSizeMake(tagHeight + tagMargin + tSize.width + tagMargin + tagCloseButton + tagMargin, tagHeight);
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.layer.backgroundColor = [self.tBackgroundColor CGColor];
    UIImageView * headImg = [[UIImageView alloc] initWithImage:self.tImage];
    [headImg setBackgroundColor:[UIColor purpleColor]];
    [headImg setFrame:CGRectMake(0.0f, 0.0f, [self getTagSize].height, [self getTagSize].height)];
    [self addSubview:headImg];
    CGSize tSize = [self.tTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize]}];
    [self.tTitle drawInRect:CGRectMake(tagHeight + tagMargin, ([self getTagSize].height / 2.0f) - (tSize.height / 2.0f), tSize.width, tSize.height)
             withAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize], NSForegroundColorAttributeName:self.tLabelColor}];

    AOTagCloseButton *close = [[AOTagCloseButton alloc] initWithFrame:CGRectMake([self getTagSize].width - tagHeight, 0.0, tagHeight, tagHeight) withColor:self.tCloseButtonColor];
    [self addSubview:close];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagSelected:)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:recognizer];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidAddTag:)])
    {
        [self.delegate performSelector:@selector(tagDidAddTag:) withObject:self];
    }
}
- (void)tagSelected:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidSelectTag:)])
    {
        [self.delegate performSelector:@selector(tagDidSelectTag:) withObject:self];
    }
}
- (void)tagClose:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidRemoveTag:)])
    {
        [self.delegate performSelector:@selector(tagDidRemoveTag:) withObject:self];
    }
    [(CusTagList *)[self superview] removeTag:self];
}
@end

@implementation AOTagCloseButton
- (id)initWithFrame:(CGRect)frame withColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        [self setCColor:color];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(rect.size.width - tagCloseButton + 1.0, (rect.size.height - tagCloseButton) / 2.0)];
    [bezierPath addLineToPoint:CGPointMake(rect.size.width - (tagCloseButton * 2.0) + 1.0, ((rect.size.height - tagCloseButton) / 2.0) + tagCloseButton)];
    [self.cColor setStroke];
    bezierPath.lineWidth = 2.0;
    [bezierPath stroke];
    UIBezierPath *bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint:CGPointMake(rect.size.width - tagCloseButton + 1.0, ((rect.size.height - tagCloseButton) / 2.0) + tagCloseButton)];
    [bezier2Path addLineToPoint:CGPointMake(rect.size.width - (tagCloseButton * 2.0) + 1.0, (rect.size.height - tagCloseButton) / 2.0)];
    [self.cColor setStroke];
    bezier2Path.lineWidth = 2.0;
    [bezier2Path stroke];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClose:)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:recognizer];
}
- (void)tagClose:(id)sender
{
    if ([[self superview] respondsToSelector:@selector(tagClose:)])
    {
        [[self superview] performSelector:@selector(tagClose:) withObject:self];
    }
}
@end
