import SpriteKit
func animatePule(label : SKLabelNode){
    let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
    let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
    let sequence = SKAction.sequence([scaleUp, scaleDown])
    label.run(SKAction.repeatForever(sequence))
}
