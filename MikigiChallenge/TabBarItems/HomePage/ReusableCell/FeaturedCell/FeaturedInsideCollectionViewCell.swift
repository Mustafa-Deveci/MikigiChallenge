//
//  FeaturedInsideCollectionViewCell.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 13.10.2023.
//

import UIKit

public enum featuredInsideIdentifier {
    static let featuredInsideIdentifier = "FeaturedInsideCollectionViewCell"
}

class FeaturedInsideCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var featuredCityLabel: UILabel!
    @IBOutlet weak var featuredCountryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
