//
//  CoreDataManager.h
//  MyLover
//
//  Created by joker on 15/12/14.
//  Copyright © 2015年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define ManagerObjectModelFileName @"resources"

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *perStoreCoordinator;

+ (instancetype) sharedCoreDataManager;

- (void)saveContext;

@end
