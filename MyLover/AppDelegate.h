//
//  AppDelegate.h
//  MyLover
//
//  Created by joker on 15/12/10.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "APService.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
{

    BOOL loginState;            // 账号登陆状态
    Reachability *_reach;       // 网络到达
    NetworkStatus _status;      // 网络状态

}
@property (strong, nonatomic) UIWindow  *window;
@property (strong, nonatomic) UIViewController * viewController;
@end

