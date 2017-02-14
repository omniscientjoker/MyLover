//
//  DEFINE.h
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#ifndef NewHouse_DEFINE_h                   //自定义头文件
#define NewHouse_DEFINE_h

#define GY_IOS7                        ([[UIDevice currentDevice].systemVersion doubleValue]>=7)
//获取vertion

//屏幕尺寸
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height



// 颜色 参数格式为：0xFFFFFF
#define kColorWithRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
                 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define kColorRGB(r,g,b) [UIColor colorWithRed: (r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

//计算颜色
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBColor(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#endif
