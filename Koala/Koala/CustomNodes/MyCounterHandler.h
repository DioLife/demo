#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
@interface MyCounterHandler : SKNode
-(MyCounterHandler *) initWithNumber:(NSInteger) initNumber;
-(void) setNumber:(NSInteger) number;
-(NSInteger) getNumber;
-(void) resetNumber;
-(void) increse;
@end
