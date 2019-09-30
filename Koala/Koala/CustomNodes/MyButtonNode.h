#import <SpriteKit/SpriteKit.h>
typedef void (^AnonBlock)(void);
@interface MyButtonNode : SKSpriteNode
-(id) initWithDefaultTexture:(SKTexture *) defaultTexture andTouchedTexture:(SKTexture *)touchedTexture;
-(void) setMethod:(void (^)(void)) returnMethod;
-(void) runMethod;
+(void) removeButtonPressed:(NSArray *) nodes;
+(BOOL) isButtonPressed:(NSArray *) nodes;
+(void) doButtonsActionBegan:(SKNode *)node touches:(NSSet *)touches withEvent:(UIEvent *)event;
+(void) doButtonsActionEnded:(SKNode *)node touches:(NSSet *)touches withEvent:(UIEvent *)event;
@end
