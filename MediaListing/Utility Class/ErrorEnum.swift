//
//  RRErrorEnum.swift
//  MediaListing
//
//  Created by Rahul Mayani on 25/03/21.
//

import Foundation

enum RRError: LocalizedError {
    case unauthorized
    case noInternetConnection

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Access is denied. User is unauthorized."
        case .noInternetConnection:
            return "Please check your internet connection and try again later."
        }
    }
}
