//
//  MyThemes.swift
//  Demo
//
//  Created by Gesen on 16/3/14.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import Foundation
import SwiftTheme

private let lastThemeIndexKey = "lastedThemeIndex"
private let defaults = UserDefaults.standard

enum MyThemes: Int {
    
    case red   = 0
    case blue = 1
    case green = 2
//    case blue  = 2
//    case night = 3
    
    // MARK: -
    
    static var current: MyThemes { return MyThemes(rawValue: ThemeManager.currentThemeIndex)! }
    static var before = MyThemes.red
    
    // MARK: - Switch Theme
    
    static func switchTo(theme: MyThemes) {
        before = current
        ThemeManager.setTheme(index: theme.rawValue)
        
        switch theme {
        case .red   : ThemeManager.setTheme(plistName: "Red", path: .mainBundle)
        case .blue : ThemeManager.setTheme(plistName: "Blue", path: .mainBundle)
        case .green :ThemeManager.setTheme(plistName: "Green", path: .mainBundle)
        }
    }
    
    static func switchToNext() {
        var next = ThemeManager.currentThemeIndex + 1
        if next > 2 { next = 0 } // cycle and without Night
        switchTo(theme: MyThemes(rawValue: next)!)
    }
    
    // MARK: - Switch Night
    
//    static func switchNight(isToNight: Bool) {
//        switchTo(theme: isToNight ? .night : before)
//    }
    
//    static func isNight() -> Bool {
//        return current == .night
//    }
    
    // MARK: - Save & Restore
    
    static func restoreLastTheme() {
        switchTo(theme: MyThemes(rawValue: defaults.integer(forKey: lastThemeIndexKey))!)
    }
    
    static func saveLastTheme() {
        defaults.set(ThemeManager.currentThemeIndex, forKey: lastThemeIndexKey)
    }
    
}
