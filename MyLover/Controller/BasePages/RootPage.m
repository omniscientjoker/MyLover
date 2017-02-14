//
//  RootPage.m
//  MyLover
//
//  Created by joker on 15/12/11.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "RootPage.h"
#import "HomePage.h"
#import "DiaryPage.h"
#import "PoemPage.h"
@interface RootPage ()
@property(nonatomic, strong)UIVisualEffectView *backview;
@property(nonatomic, strong)HomePage           *Home;
@property(nonatomic, strong)DiaryPage          *Diary;
@property(nonatomic, strong)PoemPage           *Poem;
@property(nonatomic, strong)UINavigationController * nav1;
@property(nonatomic, strong)UINavigationController * nav2;
@property(nonatomic, strong)UINavigationController * nav3;
@end

@implementation RootPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setSide:RSPenroseSideAppearTop];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.penroseView setLeftColor:[UIColor colorWithRed:0.907806F green:0.922750F blue:0.919288F alpha:0.97F]];
    [self.penroseView setRightColor:[UIColor colorWithRed:0.907806F green:0.922750F blue:0.919288F alpha:0.97F]];
    [self.penroseView setTopColor:[UIColor colorWithRed:0.907806F green:0.922750F blue:0.919288F alpha:0.97F]];
    [self.penroseView setColorSelectedSide:YES];
    [self.penroseView setSelectColor:[UIColor colorWithRed:0.874510F green:0.945098F blue:0.929412F alpha:0.97F]];

    self.Home = [[HomePage alloc] init];
    self.Diary= [[DiaryPage alloc] init];
    self.Poem = [[PoemPage alloc] init];
    [self addButtonsToTop:@"爱" left:@"日记" right:@"诗"];
    
    [self setMainController:self.Home];
    [self.penroseView selectSide:0];
    [self showTuto];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - RSPenroseViewController Delegate
-(void)didSelectPenroseButtonAtIndex:(int)index
{
    switch (index) {
        case 0:
            [self setMainController:self.Home];
            [self.penroseView selectSide:0];
            break;
        case 1:
            [self setMainController:self.Diary];
            [self.penroseView selectSide:1];
            break;
        case 2:
            [self setMainController:self.Poem];
            [self.penroseView selectSide:2];
            break;
        default:
            break;
    }
}
-(void)didShowPenrose
{
    NSLog(@"Penrose Did Show");
}
-(void)didHidePenrose
{
    NSLog(@"Penrose Did Hide");
}

#pragma mark - Penrose Tuto
-(void)showTuto
{
    tutoImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    tutoImageView.image = [UIImage imageNamed:@"tutoA"];
    [self.view addSubview:tutoImageView];
    tutoState = 1;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if(tutoState == 1)
    {
        [UIView transitionWithView:self.view duration:0.7 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            tutoImageView.image = [UIImage imageNamed:@"tutoB"];
        } completion:nil];
        tutoState = 2;
    }else
    {
        [UIView animateWithDuration:0.7 animations:^{
            tutoImageView.alpha = 0;
        } completion:^(BOOL finished) {
            [tutoImageView removeFromSuperview];
        }];
    }

}
@end
