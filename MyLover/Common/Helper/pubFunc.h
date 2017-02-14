//
//  pubFunc.h
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pubFunc : NSObject

/**
 *  color 转 image
 *
 *  @param color
 *
 *  @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  防止返回 str 为 nil
 *
 *  @param ori 原始 str
 *
 *  @return 处理后 str
 */
+ (NSString *)controlStrIsNil:(NSString *)ori;


@end
