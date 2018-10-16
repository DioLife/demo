//
//  Person2.m
//  WHC_ModelSqliteKit
//
//  Created by William on 2018/7/31.
//  Copyright © 2018年 WHC. All rights reserved.
//

#import "Person2.h"

@implementation Person2

+ (NSArray *)whc_IgnorePropertys {
    return @[@"ignoreAttr1",
             @"ignoreAttr2",
             @"ignoreAttr3"];
}

+ (NSString *)whc_SqliteVersion {
    return @"1.0.0";
}

+ (NSString *)whc_OtherSqlitePath {
    return [NSString stringWithFormat:@"%@/Library/per.db",NSHomeDirectory()];
}
@end
