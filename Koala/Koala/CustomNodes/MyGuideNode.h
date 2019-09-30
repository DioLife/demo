#import <SpriteKit/SpriteKit.h>
typedef void (^AnonBlock)(void);
@interface MyGuideNode : SKSpriteNode
-(id) initWithTitleTexture:(SKTexture *)titleTexture andIndicatorTexture:(SKTexture *)indicatorTexture;
-(void) setMethod:(void (^)(void)) returnMethod;
-(void) runMethod;
@end
