//
//  ErrorDatePage.m
//  MyLoveSpouse
//
//  Created by joker on 15/11/25.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "ErrorDatePage.h"

@interface ErrorDatePage ()

@end

@implementation ErrorDatePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage * errImg = [UIImage imageNamed:@"error_img_cacon"];
    UIImageView * err = [[UIImageView alloc] init];
    err.image  = errImg;
    [self.view addSubview:err];
    [err mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.view).with.offset(160);
         make.centerX.equalTo(self.view.mas_centerX);
         make.height.mas_equalTo(errImg.size.height);
         make.width.mas_equalTo(errImg.size.width);
     }];

    UIImage * titleImg = [UIImage imageNamed:@"err_lable"];
    UIImageView * title= [[UIImageView alloc] init];
    title.image = titleImg;
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(err.mas_bottom).with.offset(10);
         make.centerX.equalTo(self.view.mas_centerX);
         make.height.mas_equalTo(titleImg.size.height);
         make.width.mas_equalTo(titleImg.size.width);
     }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
