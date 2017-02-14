//
//  AddNewPoemPage.m
//  MyLover
//
//  Created by joker on 15/12/17.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "AddNewPoemPage.h"
#import "QuartzCore/QuartzCore.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CusTag.h"
@interface AddNewPoemPage ()<CLLocationManagerDelegate,MKMapViewDelegate,UITextViewDelegate,CusTagDelegate,CusTagListDelegate>
{
    double  duration;
    CGRect  keyboardF;
    CGFloat bootomOrigin;
    CGFloat move;
    CGFloat textViewY;
    CGPoint buttonSet;
    NSString * tagTit;
    CGFloat orgineY;
}
@property(nonatomic, strong)CusTagList * tagList;
@property(nonatomic, strong)UIView     * btnView;
@end

@implementation AddNewPoemPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    orgineY = 200;

    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"button_type_back"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"button_type_back"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.view).with.offset(24);
         make.right.equalTo(self.view).with.offset(-12);
         make.width.mas_equalTo(@40);
         make.height.mas_equalTo(@40);
     }];

    [self initTextView];
    [self initKeyBoardBtn];
    [self initTitleView];

}

#pragma mark initUI
-(void)initTitleView
{
    self.tagList = [[CusTagList alloc] initWithFrame:CGRectMake(20, 170, SCREENWIDTH-40, 30) TypeEdit:YES];
    self.tagList.delegate = self;
    [self.tagList setDelegate:self];
    [self.view addSubview:self.tagList];

    self.namefield = [[UITextField alloc] init];
    self.namefield.placeholder = @"诗名";
    self.namefield.backgroundColor = [UIColor clearColor];
    self.namefield.layer.masksToBounds = YES;
    self.namefield.clipsToBounds=YES;
    self.namefield.layer.borderColor = RGB(37, 193, 206).CGColor;
    self.namefield.layer.borderWidth = 1.5;
    self.namefield.layer.cornerRadius = 5.0;
    [self.view addSubview:self.namefield];
    [self.namefield mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.equalTo(self.tagList.mas_top).with.offset(-45);
         make.left.equalTo(self.view).with.offset(20);
         make.width.mas_equalTo(SCREENWIDTH-100);
         make.height.mas_equalTo(@25);
     }];

    self.authfield = [[UITextField alloc] init];
    self.authfield.placeholder = @"作者";
    self.authfield.backgroundColor = [UIColor clearColor];
    self.authfield.layer.masksToBounds = YES;
    self.authfield.clipsToBounds=YES;
    self.authfield.layer.borderColor = RGB(37, 193, 206).CGColor;
    self.authfield.layer.borderWidth = 1.5;
    self.authfield.layer.cornerRadius = 5.0;
    [self.view addSubview:self.authfield];
    [self.authfield mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.equalTo(self.tagList.mas_top).with.offset(-10);
         make.left.equalTo(self.view).with.offset(20);
         make.width.mas_equalTo(SCREENWIDTH-100);
         make.height.mas_equalTo(@25);
     }];

    self.AddTag = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.AddTag setImage:[UIImage imageNamed:@"tag_add"] forState:UIControlStateNormal];
    [self.AddTag addTarget:self action:@selector(AddNewTagButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.AddTag];
    [self.AddTag mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.equalTo(self.tagList.mas_top).with.offset(-15);
         make.left.equalTo(self.authfield.mas_right).with.offset(15);
         make.width.mas_equalTo(50);
         make.height.mas_equalTo(50);
     }];


}
-(void)initTextView
{
    CGFloat height;
    if (SCREENHEIGHT>480){
        height = 300;
    }else{
        height = 180;
    }
    textViewY = 200;
    CGFloat width  = SCREENWIDTH-40;
    self.infoField = [[UITextView alloc] initWithFrame:CGRectMake(20, textViewY, width, height)]; //初始化大小并自动释放
    self.infoField.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    self.infoField.font = [UIFont fontWithName:@"Arial" size:21.0];//设置字体名字和字体大小
    self.infoField.delegate = self;//设置它的委托方法
    self.infoField.backgroundColor = [UIColor clearColor];//设置它的背景颜色
    self.infoField.layer.masksToBounds = YES;
    self.infoField.clipsToBounds=YES;
    self.infoField.layer.borderColor = RGB(37, 193, 206).CGColor;
    self.infoField.layer.borderWidth = 1.5;
    self.infoField.layer.cornerRadius = 5.0;
    self.infoField.returnKeyType = UIReturnKeyDefault;//返回键的类型
    self.infoField.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.infoField.scrollEnabled = YES;//是否可以拖动
    self.infoField.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    [self.view addSubview: self.infoField];//加入到整个页面中

    self.btnView = [[UIView alloc] init];
    self.btnView.backgroundColor = [UIColor clearColor];
    NSArray * arr = [NSArray arrayWithObjects:@"button_set_location",@"button_set_Img",@"button_set_time",nil];
    for ( int i = 0 ; i < 3 ; i ++ )
    {
        CGFloat x = 40 * i;
        UIButton * btn = [self tapBtn];
        btn.tag = 10000+1;
        [btn setImage:[UIImage imageNamed:[arr objectAtIndex:i]] forState:UIControlStateNormal];
        [self.btnView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.centerY.equalTo(self.btnView.mas_centerY);
             make.left.equalTo(self.btnView.mas_left).with.offset(x);
             make.width.mas_equalTo(@40);
             make.height.mas_equalTo(@40);
         }];
    }
    [self.view addSubview:self.btnView];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.view.mas_centerX);
         make.top.equalTo(self.infoField.mas_bottom).with.offset(10);
         make.width.mas_equalTo(@120);
         make.height.mas_equalTo(@40);
     }];



}
-(void)initKeyBoardBtn
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    [topView setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"Hello" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:helloButton,btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    [self.infoField setInputAccessoryView:topView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (UIButton *)tapBtn
{
    UIButton * btn = [[UIButton alloc] init];
    [btn setBackgroundColor:[UIColor clearColor]];
    btn.layer.borderWidth = 0.2f;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    [btn addTarget:self action:@selector(clickBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    return btn;
}
#pragma mark textDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:duration animations:^{
        if (keyboardF.origin.y < bootomOrigin)
        {
            CGPoint cent = self.infoField.center;
            move = bootomOrigin - keyboardF.origin.y;
            cent = CGPointMake(cent.x, cent.y - move);
            [self positionAnimationPhotoView:self.infoField Point:cent time:duration];
        }
        else
        {
            CGPoint cent = self.infoField.center;
            cent = CGPointMake(cent.x, cent.y + move);
            [self positionAnimationPhotoView:self.infoField Point:cent time:duration];
        }
    }];
}
-(void)textViewDidChange:(UITextView *)textView
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;
    paragraphStyle.paragraphSpacing = 2;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                       NSParagraphStyleAttributeName:paragraphStyle};
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:duration animations:^{
        if (keyboardF.origin.y < bootomOrigin)
        {
            CGPoint cent = self.infoField.center;
            move = bootomOrigin - keyboardF.origin.y;
            cent = CGPointMake(cent.x, cent.y - move);
            [self positionAnimationPhotoView:self.infoField Point:cent time:duration];
        }
        else
        {
            CGPoint cent = self.infoField.center;
            cent = CGPointMake(cent.x, cent.y + move);
            [self positionAnimationPhotoView:self.infoField Point:cent time:duration];
        }
    }];
    self.navigationItem.rightBarButtonItem = nil;
}
- (void)leaveEditMode
{
    [self.infoField resignFirstResponder];
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    bootomOrigin =  self.infoField.bounds.size.height+self.infoField.frame.origin.y;
}


#pragma mark action
-(void)positionAnimationPhotoView:(UIView *)view Point:(CGPoint)point time:(float)time
{
    [UIView beginAnimations:@"PositionAnition" context:NULL];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    view.center = CGPointMake(point.x, point.y);
    [UIView commitAnimations];
}
-(void)clickBack:(id)sender
{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"zoomyOut";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)clickBtnEvent:(UIButton *)sender
{

}
-(void)dismissKeyBoard
{
    [self.infoField resignFirstResponder];
}
-(void)AddNewTagButton
{
    if (self.tagList.tags.count < 5 )
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"TAG" message:@"添加标签" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
         {
             textField.placeholder = @"Tag";
             [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
         }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
        {
            tagTit = alertController.textFields.firstObject.text;
            [self AddNewTag:tagTit];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
        }];
        okAction.enabled = NO;
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"TAG" message:@"添加标签已经超过5个了" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        okAction.enabled = YES;
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }

}
- (void)alertTextFieldDidChange:(NSNotification *)notification
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *login = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = login.text.length > 0;
    }
}

#pragma mark - Tag delegate
- (void)AddNewTag:(NSString*)tagTitle
{
    [self.tagList addTag:tagTitle
               withImage:@"Tag_img"
          withLabelColor:[UIColor blackColor]
     withBackgroundColor:[UIColor whiteColor]
    withCloseButtonColor:[UIColor blackColor]];
}
- (void)tagDidAddTag:(CusTag *)tag
{
    CGFloat setY = self.tagList.frame.origin.y + self.tagList.frame.size.height - orgineY;
    if (setY > 0)
    {
        CGPoint cent = self.infoField.center;
        cent = CGPointMake(cent.x, cent.y+setY+2);
        orgineY = self.tagList.frame.origin.y + self.tagList.frame.size.height;
        [self positionAnimationPhotoView:self.infoField Point:cent time:1.0];
    }
}
- (void)tagDidRemoveTag:(CusTag *)tag
{
    CusTag * currectTag = [self.tagList.tags lastObject];
    buttonSet = currectTag.frame.origin;
    self.AddTag.frame = CGRectMake(buttonSet.x-tag.frame.size.width + 5, buttonSet.y, 25, 25);
}
- (void)tagDidSelectTag:(CusTag *)tag
{
    NSLog(@"Tag > %@ has been selected", tag);
}





-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.rootPenroseController hidePenroseView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
