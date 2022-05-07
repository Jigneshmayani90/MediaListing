//
//  Structs.swift
//  MediaListing
//
//  Created by Rahul Mayani on 25/03/21.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

public struct APIEndPoint {
    
    static let endPointURL = Environment.production.rawValue
    
    private enum Environment:String {
        case develop = "local host"
        case staging = "stage"
        case production = "https://www.monclergroup.com/wp-json/"
    }
    
    private static let version = "mobileApp/v1/"
    
    struct Name {
        static let mediaList = endPointURL + version + "getPressReleasesDocs"
    }
}


public struct AppDateFormat {
    static let date = "MM/dd/yyyy"
   
    static let dateandtime = "E, d MMM yyyy HH:mm:ss Z"
}

enum AppWebFiles: String {
    case pdf
    case xls
    case xlsx
    case csv
  
    var mimeType: String {
        return self.rawValue.mimeTypeForPathExtension()
    }
}
