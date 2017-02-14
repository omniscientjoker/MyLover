//
//  Poem.h
//  MyLover
//
//  Created by joker on 15/12/14.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Poem : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * headImg;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSDate   * time;

@end
