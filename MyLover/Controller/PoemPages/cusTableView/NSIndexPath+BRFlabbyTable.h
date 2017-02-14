//
//  NSIndexPath+BRFlabbyTable.h
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (BRFlabbyTable)

- (NSIndexPath *)nextIndexPathInTable:(UITableView *)tableView;

- (NSIndexPath *)previousIndexPathInTable:(UITableView *)tableView;

@end