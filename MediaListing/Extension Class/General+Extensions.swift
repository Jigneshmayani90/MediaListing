//
//  General+Extensions.swift
//  MediaListing
//
//  Created by Rahul Mayani on 25/03/21.
//

import Foundation
import UIKit
import MobileCoreServices

extension UIStoryboard{
    func loadViewController<T>() -> T{
        return self.instantiateViewController(withIdentifier: "\(T.self)") as! T
    }
}

extension String {
    
    func isValidURL() -> Bool {
        /*guard let urlString = self else {return false}
        guard let url = NSURL(string: urlString) else {return false}
        if !UIApplication.sharedApplication().canOpenURL(url) {return false}*/
        
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
    
    func mimeTypeForPathExtension() -> String {
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, self as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
    func date(_ dateFormate: String? = nil) -> Date? {
        
        if let timeStamp = TimeInterval(self) {
            return timeStamp.date()
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormate
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone.current
            return dateFormatter.date(from: self)
        }
    }
    
    func timeStamp() -> Date {
        var orderDate = TimeInterval(self) ?? 0
        if self.count > 10 {
            orderDate = orderDate / 1000
        }
        return orderDate.date()
    }
}

public extension TimeInterval {
    
    func date() -> Date {
        return Date(timeIntervalSince1970: self)
    }
    
    func string(dateFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormate
        return dateFormatter.string(from: date())
    }
    
    func hoursMinutes () -> (Int, Int) {
        return ((Int(self) / 3600), ((Int(self) % 3600) / 60))
    }
}


extension Date {
        
    public func string(dateFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormate
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
}

extension CGRect {
    
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
