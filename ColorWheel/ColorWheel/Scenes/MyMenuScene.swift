import SpriteKit
class MyMenuScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 15/255, green: 38/255, blue: 62/255, alpha: 1.0)
        addLogo()
        addLabels()
    }
    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "colorWheelLogo")
        logo.size = CGSize(width: frame.size.width/1.5, height: frame.size.width/3)
        logo.position = CGPoint(x: frame.midX, y: frame.maxY - frame.size.width/3)
        addChild(logo)
    }
    func addLabels() {
        let playLabel = createTextNode(text: "TAP TO PLAY", nodeName: "PlayLabel", position: CGPoint(x: frame.midX, y: frame.midY), fontSize: CGFloat(50.0), fontColor: UIColor.white)
        let highScoreLabel = createTextNode(text: "High Score: \(UserDefaults.standard.integer(forKey: "high_score"))", nodeName: "HighScoreLabel", position: CGPoint(x: frame.midX, y: frame.midY), fontSize: CGFloat(35.0), fontColor: UIColor.white)
        let recentScoreLabel = createTextNode(text: "Recent Score: \(UserDefaults.standard.integer(forKey: "recent_score"))", nodeName: "RecentScoreLabel", position: CGPoint(x: frame.midX, y: frame.midY), fontSize: CGFloat(35.0), fontColor: UIColor.white)
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height*4)
        recentScoreLabel.position = CGPoint(x: frame.midX, y: highScoreLabel.position.y - recentScoreLabel.frame.size.height*2)
        addChild(playLabel)
        animatePule(label: playLabel)
        addChild(highScoreLabel)
        addChild(recentScoreLabel)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = MyGameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }
}
