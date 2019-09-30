import SpriteKit
enum PhysicsCategories{
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1
    static let switchCategory: UInt32 = 0x1 << 1
}
enum ZPostions{
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}
enum GameColors{
    static let colors = [
        UIColor(red: 191/255, green: 83/255,  blue: 80/255,  alpha: 1.0),
        UIColor(red: 254/255, green: 109/255, blue: 104/255, alpha: 1.0),
        UIColor(red: 254/255, green: 200/255, blue: 66/255,  alpha: 1.0),
        UIColor(red: 0/255,   green: 149/255, blue: 56/255,  alpha: 1.0),
        UIColor(red: 93/255,  green: 150/255, blue: 219/255, alpha: 1.0),
        UIColor(red: 0/255,   green: 113/255, blue: 207/255, alpha: 1.0)
    ]
}
enum SwitchState: Int{
    case maroon, pink, yellow, green, blue, navy
}
enum Layout {
    static let backgroundColor = UIColor(red: 15/255, green: 38/255, blue: 62/255, alpha: 1.0)
    static let font: String = "AppleSDGothicNeo-Regular"
}
