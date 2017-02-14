//
//  AddNewPoemPage.h
//  MyLover
//
//  Created by joker on 15/12/17.
//  Copyright © 2015年 joker. All rights reserved.
//

#import "BasePages.h"

@interface AddNewPoemPage : BasePages
@property (nonatomic, strong)UITextField * namefield;
@property (nonatomic, strong)UITextField * authfield;
@property (nonatomic, strong)UITextView  * infoField;
@property (nonatomic, strong)UIButton    * AddTag;
@property (nonatomic, strong)UIView      * tagView;
@end
