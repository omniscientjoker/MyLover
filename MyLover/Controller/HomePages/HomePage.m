//
//  HomePage.m
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "HomePage.h"
#import "CusButtonView.h"
@interface HomePage ()
@property(strong, nonatomic) UIButton         * button;
@property(strong, nonatomic) CAGradientLayer  * gradientLayer;
@property(strong, nonatomic) UINavigationController *navController;
@end

@implementation HomePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeColorView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnShow) name:@"DismissedMenuSuccessed" object:nil];
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setImage:[UIImage imageNamed:@"button_touch"] forState:UIControlStateHighlighted];
    [_button setImage:[UIImage imageNamed:@"button_touch"] forState:UIControlStateNormal];
    _button.frame = CGRectMake(0, 0, SCREENWIDTH/2, SCREENWIDTH/2);
    _button.center = self.view.center;
    [_button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];


    
}


#pragma mark CusButtonView
-(void)btnShow
{
    if (_button.hidden == YES)
    {
        _button.hidden = NO;
    }
}
- (void)showMenu
{
    _button.hidden = YES;
    CusButtonView *menuView = [[CusButtonView alloc] init];
    [menuView addMenuItemWithTitle:@"Text" andIcon:[UIImage imageNamed:@"button_type_text"] andSelectedBlock:^{
        _button.hidden = NO;
        [self btnMailClicked];
        NSLog(@"Text selected");
    }];
    [menuView addMenuItemWithTitle:@"Photo" andIcon:[UIImage imageNamed:@"button_type_photo"] andSelectedBlock:^{
        _button.hidden = NO;
        NSLog(@"Photo selected");
    }];
    [menuView addMenuItemWithTitle:@"Quote" andIcon:[UIImage imageNamed:@"button_type_quote"] andSelectedBlock:^{
        _button.hidden = NO;
        NSLog(@"Quote selected");
    }];
    [menuView show];
}

#pragma mark button click
-(void)btnMailClicked{
    
}
#pragma mark view UI
-(void)changeColorView
{
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.gradientLayer];
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    NSArray * b = [[NSArray alloc] initWithObjects:RGB(235, 73, 41),RGB(255, 216, 0), nil];
    UIColor * top = [b objectAtIndex:1];
    UIColor * bottom = [b objectAtIndex:0];
    self.gradientLayer.colors = @[(__bridge id)top.CGColor,
                                  (__bridge id)bottom.CGColor];
    self.gradientLayer.locations = @[@(0.3f) ,@(1.0f)];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_button)
    {
        if (_button.hidden == YES)
        {
            _button.hidden = NO;
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
