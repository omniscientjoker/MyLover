//
//  BasePages.m
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "BasePages.h"

@interface BasePages ()


@end

@implementation BasePages

- (void)viewDidLoad{
    [super viewDidLoad];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
    NSForegroundColorAttributeName:[UIColor whiteColor]
    }];
    self.navigationController.navigationBarHidden = YES;
}
-(void)doBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNaviTitle:(NSString *)title{
    if (self.navigationController.navigationBar != nil){
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{            NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
            NSForegroundColorAttributeName:[UIColor whiteColor]
         }];
        self.title = title;
    }
}
@end
