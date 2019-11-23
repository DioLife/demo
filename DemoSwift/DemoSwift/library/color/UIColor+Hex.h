//
//  UIColor+Hex.h
//  MyGameforBjl
//
//  Created by Carr on 2018/5/15.
//  Copyright © 2018年 Carr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
