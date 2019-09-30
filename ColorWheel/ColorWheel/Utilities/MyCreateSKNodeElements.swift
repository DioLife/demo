import SpriteKit
func createTextNode(text: String, nodeName: String, position: CGPoint, fontSize: CGFloat, fontColor: UIColor) -> SKLabelNode {
    let labelNode = SKLabelNode(fontNamed: Layout.font)
    labelNode.name = nodeName
    labelNode.text = text
    labelNode.fontSize = fontSize
    labelNode.fontColor = fontColor
    labelNode.position = position
    return labelNode;
}
func createSpriteNode(node: SKSpriteNode, name: String, size: CGSize, position: CGPoint, zPosition: CGFloat, physicsCategory: UInt32 ) -> SKSpriteNode {
    let spriteNode = node
    spriteNode.name = name
    spriteNode.size = size
    spriteNode.position = position
    spriteNode.zPosition = zPosition
    spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: spriteNode.size.width/2)
    spriteNode.physicsBody?.categoryBitMask = physicsCategory
    return spriteNode
}
