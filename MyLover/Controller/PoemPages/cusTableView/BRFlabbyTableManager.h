//
//  BRFlabbyTableManager.h
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BRFlabbyTableManager;
@protocol BRFlabbyTableManagerDelegate <NSObject>
- (UIColor *)flabbyTableManager:(BRFlabbyTableManager *)tableManager flabbyColorForIndexPath:(NSIndexPath *)indexPath;
@optional
- (void)flabbyTableManager:(BRFlabbyTableManager *)tableManager scrolledWithVelocity:(CGFloat)velocity;
@end

@interface BRFlabbyTableManager : NSObject
@property (assign, nonatomic)           id<BRFlabbyTableManagerDelegate>    delegate;
@property (assign, nonatomic, readonly) CGFloat                             verticalVelocity;
@property (weak, nonatomic)             UITableView                         *tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;
@end