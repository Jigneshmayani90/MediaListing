//
//  MediaModel.swift
//  MediaListing
//
//  Created by Rahul Mayani on 25/03/21.
//

import Foundation

class MediaModel: NSObject{

    var mediaDate : MediaDate!
    var mediaId : Int!
    var mediaTitleCustom : String!
    var mediaType : String!
    var mediaUrl : String!
    var mediaUrlBig : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]){
        if let mediaDateData = dictionary["mediaDate"] as? [String: Any]{
            mediaDate = MediaDate(fromDictionary: mediaDateData)
        }
        mediaId = dictionary["mediaId"] as? Int
        mediaTitleCustom = dictionary["mediaTitleCustom"] as? String
        mediaType = dictionary["mediaType"] as? String
        mediaUrl = dictionary["mediaUrl"] as? String
        mediaUrlBig = dictionary["mediaUrlBig"] as? String
    }
}

class MediaDate : NSObject{

    var dateString : String!
    var year : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String: Any]){
        dateString = dictionary["dateString"] as? String
        year = dictionary["year"] as? String
    }
}
