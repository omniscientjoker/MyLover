//
//  CusTag.h
//  MyLover
//
//  Created by joker on 15/12/18.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CusTag;
@protocol CusTagDelegate <NSObject>
@optional
- (void)tagDistantImageDidLoad:(CusTag *)tag;
- (void)tagDistantImageDidFailLoad:(CusTag *)tag withError:(NSError *)error;
- (void)tagDidAddTag:(CusTag *)tag;
- (void)tagDidRemoveTag:(CusTag *)tag;
- (void)tagDidSelectTag:(CusTag *)tag;
@end

@class CusTagList;
@protocol CusTagListDelegate <NSObject>
@optional
- (void)tagShouldBeAdd:(CusTagList *)taglist;
@end

@interface CusTagList : UIView
@property (nonatomic, weak)   id <CusTagDelegate> delegate;
@property (nonatomic, retain) id <CusTagListDelegate> listDelegate;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, assign) BOOL TypeEdit;
@property (nonatomic, strong) UIButton       *addBtn;
- (id)initWithFrame:(CGRect)frame TypeEdit:(BOOL)type;
- (void)addTag:(NSString *)tTitle withImage:(NSString *)tImage;
- (void)addTag:(NSString *)tTitle withImage:(NSString *)tImage withLabelColor:(UIColor *)labelColor withBackgroundColor:(UIColor *)backgroundColor withCloseButtonColor:(UIColor *)closeColor;
- (void)addTags:(NSArray *)tags;
- (void)removeTag:(CusTag *)tag;
- (void)removeAllTag;
@end


@interface CusTag : UIView
@property (nonatomic, weak) id <CusTagDelegate> delegate;
@property (nonatomic, strong) UIColor *tLabelColor;
@property (nonatomic, strong) UIColor *tBackgroundColor;
@property (nonatomic, strong) UIColor *tCloseButtonColor;
@property (nonatomic, strong) UIImage *tImage;
@property (nonatomic, copy)   NSString *tTitle;
- (CGSize)getTagSize;
@end


@interface AOTagCloseButton : UIView
@property (nonatomic, strong) UIColor *cColor;
- (id)initWithFrame:(CGRect)frame withColor:(UIColor *)color;
@end
