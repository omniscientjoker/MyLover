//
//  DateHelper.h
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface DateHelper : NSObject
singleton_interface(DateHelper)

+(BOOL)PdNetwork;

+(BOOL)isEmpty:(NSString *)str;

+(BOOL)checkPassWord:(NSString *)str;

+(NSString *)editStringWithTitleTimeStr:(NSString *)OrgStr;

+(NSString *)editStringWithTimeStr:(NSString *)OrgStr;

+(void) setAutoLayourtLab:(UILabel *)label;

+(CGSize) getAutoCGsizeWithSize:(CGSize)size Text:(NSString*)str;

+(NSString *)getTime;

+(NSString *)controlStrIsNil:(NSString *)ori;

+(NSString *)meetingDataResult:(NSString *)start endTime:(NSString *)end;

@end
