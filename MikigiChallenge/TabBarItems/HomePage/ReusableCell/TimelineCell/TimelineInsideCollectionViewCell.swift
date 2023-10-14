//
//  TimelineInsideCollectionViewCell.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 14.10.2023.
//

import UIKit

public enum timelineInsideIdentifier {
    static let timelineInsideIdentifier = "TimelineInsideCollectionViewCell"
}

class TimelineInsideCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timelineImageView: UIImageView!
    @IBOutlet weak var timelineTitle: UILabel!
    @IBOutlet weak var timelineDate: UILabel!
    @IBOutlet weak var timelineCountryCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
