//
//  DateHelper.m
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper
singleton_implementation(DateHelper)

+(BOOL)checkPassWord:(NSString *)str
{
    NSString    *  regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *  pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:str])
    {
        return YES ;
    }
    else
    {
        return NO;
    }
}
+(BOOL)PdNetwork
{
    Reachability *r=[Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus])
    {
        case NotReachable:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络异常，请稍后重试！" preferredStyle:UIAlertControllerStyleAlert];
            // Create the actions.
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
            {
                NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
            }];
            [alertController addAction:cancelAction];
            return NO;
        }
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi");
            return YES;
            break;
        case ReachableViaWWAN:
        {
            NSLog(@"wlan");
            return NO;
        }
            break;
        default:
            break;
    }

    return NO;
}

+(BOOL)isEmpty:(NSString *)str
{

    if (!str)
    {
        return YES;
    }
    else
    {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}
+(NSString *)editStringWithTitleTimeStr:(NSString *)OrgStr
{
    NSArray *array = [OrgStr componentsSeparatedByString:@" "];
    NSString * qian = [array objectAtIndex:0];
    return qian;
}
+(NSString *)editStringWithTimeStr:(NSString *)OrgStr
{
    NSArray *array = [OrgStr componentsSeparatedByString:@" "];
    NSString * qian = [array objectAtIndex:0];
    NSString * year  = [qian substringWithRange:NSMakeRange(0,4)];
    NSString * month = [qian substringWithRange:NSMakeRange(5,2)];
    NSString * day   = [qian substringWithRange:NSMakeRange(8,2)];
    NSString * yearT = @"YEAR";
    NSString * monthT = @"MONTH";
    NSString * dayT = @"DAY";
    NSString * retSS = [NSString stringWithFormat:@"%@%@%@%@%@%@",year,yearT,month,monthT,day,dayT];
    return retSS;
}

+ (void) setAutoLayourtLab:(UILabel *)label
{
    CGSize maxSize = CGSizeMake(label.frame.size.width, 999);
    label.adjustsFontSizeToFitWidth = NO;
    //姜淼 设定计算宽高的模式和字体大小
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = label.lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    //姜淼 计算自适应lab的大小
    CGSize actualSize = [label.text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    CGRect rect = label.frame;
    rect.size.height = actualSize.height;
    label.frame = rect;
    
}

+(CGSize) getAutoCGsizeWithSize:(CGSize)size Text:(NSString*)str
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:11.0f]};

    CGSize retSize = [str boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return retSize;
}

+(NSString *)getTime
{
    NSDate *  senddate=[NSDate date];
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags= NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    NSString *  nsDateString= [NSString  stringWithFormat:@"%ld年%ld月%ld日",(long)year,(long)month,(long)day];
    return nsDateString;
}

/**
 *  防止返回 str 为 nil
 *
 *  @param ori 原始 str
 *
 *  @return 处理后 str
 */
+ (NSString *)controlStrIsNil:(NSString *)ori
{
    NSString *result = ori == nil ? @"" : ori;
    return result;
}

+ (NSString *)meetingDataResult:(NSString *)start endTime:(NSString *)end
{
    NSRange range = [[self controlStrIsNil:end] rangeOfString:@" "];
    NSString *endTime = nil;
    NSString *startTime = nil;
    if (range.location != NSNotFound && end.length > range.location + 1)
    {
        NSString * monthT = @"月";
        NSString * dayT = @"日";
        NSArray *array01 = [start componentsSeparatedByString:@"-"];
        NSString * month = [array01 objectAtIndex:1];
        NSArray *array02 = [[array01 objectAtIndex:2] componentsSeparatedByString:@" "];
        NSString * day   = [array02 objectAtIndex:0];
        NSString * time  = [array02 objectAtIndex:1];
        startTime = [NSString stringWithFormat:@"%@%@%@%@ %@",month,monthT,day,dayT,time];
        endTime = [[self controlStrIsNil:end] substringFromIndex:range.location+range.length];
    }
    NSString *result = [NSString stringWithFormat:@"%@-%@",[self controlStrIsNil:startTime],[self controlStrIsNil:endTime]];
    return result;
}
@end
