//
//  DiaryPage.m
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "DiaryPage.h"

@interface DiaryPage ()
@property(strong, nonatomic) CAGradientLayer  * gradientLayer;
@end

@implementation DiaryPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeColorView];
}


-(void)changeColorView
{
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.gradientLayer];
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    NSArray * c = [[NSArray alloc] initWithObjects:RGB(29, 180, 129),RGB(30, 155, 235), nil];
    UIColor * top = [c objectAtIndex:1];
    UIColor * bottom = [c objectAtIndex:0];
    self.gradientLayer.colors = @[(__bridge id)top.CGColor,
                                  (__bridge id)bottom.CGColor];
    self.gradientLayer.locations = @[@(0.3f) ,@(1.0f)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
