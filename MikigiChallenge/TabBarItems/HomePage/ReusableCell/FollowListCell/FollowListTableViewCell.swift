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
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func followButton(_ sender: Any) {
    }
}
