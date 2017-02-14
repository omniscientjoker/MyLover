//
//  Diary.h
//  MyLover
//
//  Created by joker on 15/12/14.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Diary : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * infotext;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSDate   * time;

@end
