//
//  CAButton.m
//  demo
//
//  Created by Carr on 9/5/2019.
//  Copyright © 2019 Tool. All rights reserved.
//

#import "CAButton.h"

@implementation CAButton

-(instancetype)init{
    if (self = [super init]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [ self addGestureRecognizer:pan];
    }
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint transP = [pan translationInView:self];
    self.transform = CGAffineTransformTranslate(self.transform, transP.x, transP.y);
    [pan setTranslation:CGPointZero inView:self];
}

@end
