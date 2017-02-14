//
//  AppDelegate.m
//  MyLover
//
//  Created by joker on 15/12/10.
//  Copyright © 2015年 joker. All rights reserved.
//


#import "AppDelegate.h"
#import "IntroductionView.h"
#import "HttpManager.h"
#import "RootPage.h"
#import "ErrorDatePage.h"
@interface AppDelegate ()
@property(nonatomic, strong)IntroductionView * introductionView;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self startWatchingNetworkStatus];
    [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)categories:nil];
    [APService setupWithOption:launchOptions];
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    NSDate * NowDate = [NSDate date];
    if ([self date:NowDate])
    {
        //设置初始页面
        UIViewController * viewController;
        RootPage *  rp =[[RootPage alloc] init];
        viewController = rp;
        self.window.rootViewController = viewController;//导航视图作为根视图控制器
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        // 引导
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt", @"img_index_04txt" ,@"img_index_05txt" ,@"img_index_06txt"];
            NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg", @"img_index_04bg", @"img_index_05bg", @"img_index_06bg"];
            UIButton *enterButton = [UIButton new];
            [enterButton setBackgroundImage:[UIImage imageNamed:@"bg_bar"] forState:UIControlStateNormal];
            self.introductionView = [[IntroductionView alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames button:enterButton];
            [self.window addSubview:self.introductionView.view];
            __weak AppDelegate *weakSelf = self;
            self.introductionView.didSelectedEnter = ^()
            {
                weakSelf.introductionView = nil;
            };
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        }
    }else{
        UIViewController * viewController;
        ErrorDatePage *  ep =[[ErrorDatePage alloc] init];
        viewController = ep;
        self.window.rootViewController = viewController;//导航视图作为根视图控制器
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }
    return YES;
}

#pragma mark timecomp
- (BOOL)date:(NSDate*)date
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *Bitthday =[dateFormat dateFromString:@"2016-12-16 00:00:00"];
    if ([date compare:Bitthday] == NSOrderedAscending){
        return YES;
    }
    return YES;
}
#pragma mark 监测网络状况
- (void)startWatchingNetworkStatus
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    _reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [_reach startNotifier];
    _status = ReachableViaWiFi;
}
- (void)reachabilityChanged:(NSNotification* )note
{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus curStatus = [curReach currentReachabilityStatus];
    if (curStatus != _status)
    {
        NSString *str = nil;
        switch (curStatus)
        {
            case NotReachable:{
                str = @"网络异常,请稍后重试!";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                {
                    NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
                }];
                [alertController addAction:cancelAction];

            }
                break;
            case ReachableViaWiFi:
                str = @"wifi网络可用";
                break;
            case ReachableViaWWAN:
                str = @"3G/GPRS网络可用";
                break;
            default:
                str = @"未知网络";
                break;
        }
    }
    _status = curStatus;
}
#pragma mark 添加指纹密码
-(void)setupTouchID{
    CFErrorRef error = NULL;
    SecAccessControlRef sacObject;
    sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                kSecAccessControlUserPresence, &error);
}
#pragma mark 上传推送的token
//获得token失败
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"%@",error);
    NSLog(@"获取token失败！ Register Remote Notifications error:{%@}",[error localizedDescription]);
}
//获得token成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [APService registerDeviceToken:deviceToken];
}

#pragma mark 处理JPush传送的消息
/**
 *  1.处理APNS消息：包括系统消息更新，报备状态推送，动态更新
 *
 *  @param void NSDictionary userInfo
 *
 *  @return void
 */
-(void)handleAPNSInfo:(NSDictionary *)info
{
    if (info){
        if ([[info objectForKey:@"type"] isEqualToString:@"2"]==YES){
            NSLog(@"%@",[info objectForKey:@"type"]);
        }
    }
}
//点击推送消息跳转
-(void)pushViewControllerWithJPush:(UIViewController *)viewController{
    UIViewController *nav = self.window.rootViewController;
    if ([nav isKindOfClass:[UINavigationController class]] && nav != nil){
        UINavigationController *navVC = (UINavigationController *)nav;
        [navVC pushViewController:viewController animated:YES];
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [APService handleRemoteNotification:userInfo];
    if (application.applicationState == UIApplicationStateActive){
        if (userInfo){
            if ([[userInfo objectForKey:@"type"] isEqualToString:@"2"]==YES){
            }
        }
    }else{
        [self handleAPNSInfo:userInfo];
    }
}
#pragma mark 周期方法
- (void)applicationDidBecomeActive:(UIApplication *)application{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
-(void)applicationDidEnterBackground:(UIApplication *)application{
    
}
@end
