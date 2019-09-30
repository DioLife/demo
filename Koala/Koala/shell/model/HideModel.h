//
//  HideModel.h
//  HideDemoOC
//
//  Created by hello on 2019/5/14.
//  Copyright © 2019 Dio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HideData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HideModel : NSObject

@property(nonatomic, copy)NSString *code;
@property(nonatomic, copy)NSString *msg;
@property(nonatomic, copy)NSString *message;
@property(nonatomic, strong)HideData *data;

@end

NS_ASSUME_NONNULL_END
