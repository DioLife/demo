//
//  CAButton.m
//  demo
//
//  Created by Carr on 9/5/2019.
//  Copyright © 2019 Tool. All rights reserved.
//

#import "CAButton.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation CAButton

-(instancetype)init{
    if (self = [super init]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    //    NSLog(@"X:%f, Y:%f, width:%f, height:%f",self.frame.origin.x, self.frame.origin.y, width, height);
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationPortrait
        || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        if (y < 44) {
            self.frame = CGRectMake(self.frame.origin.x, y + 6, self.frame.size.width, self.frame.size.height);
            return;
        }
        if ((y + self.frame.size.height) > (ScreenHeight - 70)) {
            self.frame = CGRectMake(self.frame.origin.x, y - 5, self.frame.size.width, self.frame.size.height);
            return;
        }
    }else{
        if (y < 0) {
            self.frame = CGRectMake(self.frame.origin.x, y + 5, self.frame.size.width, self.frame.size.height);
            return;
        }
        if ((y + self.frame.size.height) > ScreenHeight) {
            self.frame = CGRectMake(self.frame.origin.x, y - 5, self.frame.size.width, self.frame.size.height);
            return;
        }
    }
    
    if (x < 0) {
        self.frame = CGRectMake(x + 5, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
    if ((x + self.frame.size.width) > ScreenWidth) {
        self.frame = CGRectMake(x - 5, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
    
    
    CGPoint transP = [pan translationInView:self];
    self.transform = CGAffineTransformTranslate(self.transform, transP.x, transP.y);
    [pan setTranslation:CGPointZero inView:self];
}

@end
