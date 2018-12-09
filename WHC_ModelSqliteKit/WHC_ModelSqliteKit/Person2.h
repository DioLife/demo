//
//  Person2.h
//  WHC_ModelSqliteKit
//
//  Created by William on 2018/7/31.
//  Copyright © 2018年 WHC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHC_ModelSqlite.h"
#import "Car.h"
#import "School.h"
#import "Animal.h"

@interface Person2 : Animal<WHC_SqliteInfo>
@property (nonatomic, assign) NSInteger whcId;   /// 主键
@property (nonatomic, assign) NSInteger _id;   /// 主键
@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) long age;
@property (nonatomic, assign) float weight;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) BOOL isDeveloper;
@property (nonatomic, strong) NSString * xx;
@property (nonatomic, strong) NSString * yy;
@property (nonatomic, strong) NSString * ww;
@property (nonatomic, assign) char sex;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) Car * car;
@property (nonatomic, strong) School * school;
@property (nonatomic, strong) NSNumber * zz;
@property (nonatomic, strong) NSData * data;
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) NSArray * carArray;
@property (nonatomic, strong) NSDictionary * dict;
@property (nonatomic, strong) NSDictionary * dictCar;

/// 下面是忽略属性
@property (nonatomic, strong) NSString * ignoreAttr1;
@property (nonatomic, strong) NSString * ignoreAttr2;
@property (nonatomic, strong) NSString * ignoreAttr3;

+ (NSString *)whc_SqliteVersion;
+ (NSArray *)whc_IgnorePropertys;
@end
