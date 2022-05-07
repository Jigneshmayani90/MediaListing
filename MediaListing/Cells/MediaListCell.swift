//
//  MediaListCell.swift
//  MediaListing
//
//  Created by Rahul Mayani on 25/03/21.
//

import Foundation
import UIKit

class MediaListCell: UITableViewCell {

    // MARK: - IBOutlet -
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mediaIdLabel: UILabel!
    
    // MARK: - Variable -
    public var data: MediaModel? = nil {
        didSet {
            
            titleLabel.text = data?.mediaTitleCustom ?? ""
            dateLabel.text = data?.mediaDate.dateString.date(AppDateFormat.dateandtime)?.string(dateFormate: AppDateFormat.date)
            mediaIdLabel.text = "ID: \(data?.mediaId ?? 0)"
        }
    }
    
    // MARK: - Cell Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
