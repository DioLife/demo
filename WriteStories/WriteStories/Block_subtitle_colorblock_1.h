//
//  Block_subtitle_colorblock_1.h
//  WriteStories
//
//  Created by YouXianMing on 2018/6/10.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "BaseBlockItem.h"

@interface Block_subtitle_colorblock_1 : BaseBlockItem

@property (nonatomic, strong) NSNumber *styleType;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titleFontName;
@property (nonatomic, strong) NSString *titleHexColor;
@property (nonatomic, strong) NSNumber *titleFontSize;
@property (nonatomic, strong) NSNumber *titleOpacity;
@property (nonatomic, strong) NSNumber *titleTopGap;
@property (nonatomic, strong) NSNumber *titleRightGap;
@property (nonatomic, strong) NSNumber *titleBottomGap;
@property (nonatomic, strong) NSNumber *titleLeftGap;
@property (nonatomic, strong) NSNumber *lineHeight;  // 行间距

@property (nonatomic, strong) NSNumber *wordGap;
@property (nonatomic, strong) NSNumber *borderWidth;
@property (nonatomic, strong) NSString *borderColor;
@property (nonatomic, strong) NSString *borderStyle;

@end
