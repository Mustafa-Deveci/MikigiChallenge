//
//  FollowListTableViewCell.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 15.10.2023.
//
import UIKit

class FollowListTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var popupName: UILabel!
    @IBOutlet weak var popupUsername: UILabel!
    @IBOutlet weak var popupImage: UIImageView!
    @IBOutlet weak var followButton: UIButton! 

    public var isFollow: Bool? {
        didSet {
            if let isFollow = isFollow {
                if isFollow {
                    followButton.isHidden = true
                    followButton.isEnabled = false

                } else {
                    followButton.isHidden = false
                    followButton.isEnabled = false
                }
            }
        }
    }
    
    static let identifier = "FollowListTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
