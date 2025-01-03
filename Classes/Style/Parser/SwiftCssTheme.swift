//
//  SwiftCssTheme.swift
//  SwiftCssParser
//
//  Created by Mango on 2017/6/3.
//  Copyright © 2017年 Mango. All rights reserved.
//

import UIKit

public class SwiftCssTheme {
    
    public static let updateThemeNotification = Notification.Name("SwiftCSSThemeUpdate")
    
    public enum Theme {
        case day
        case night
    }
    
    public static var theme: Theme = .day {
        didSet {
            switch theme {
            case .day:
                self.themeCSS = SwiftCSS(CssFileURL: URL.CssURL(name: "day"))
            case .night:
                self.themeCSS = SwiftCSS(CssFileURL: URL.CssURL(name: "night"))
            }
            NotificationCenter.default.post(name: updateThemeNotification, object: nil)
        }
    }
    
    public static var themeCSS = SwiftCSS(CssFileURL: URL.CssURL(name: "day"))
}

private extension URL {
    static func CssURL(name:String) -> URL {
        return Bundle.main.url(forResource: name, withExtension: "css")!
    }
}

extension UIView {
    
    private struct AssociatedKeys {
        static var selector = "themeColorSelector"
        static var key = "themeColorKey"
    }
}
