//
//  TopItemsCollectionViewCell.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 12.10.2023.
//

import UIKit

public enum topItemsCollectionIdentifier {
    static let topItems = "TopItemsCollectionViewCell"
}

class TopItemsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var straightLine: UIView!
    @IBOutlet weak var homePageTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        formatLabel()
        configureStraightLine()
    }
    func formatLabel() {
            let labelText = "DEMO FEED"
            let attributedText = NSMutableAttributedString(string: labelText)
            let range = (labelText as NSString).range(of: "FEED")
            let boldFont = UIFont.boldSystemFont(ofSize: 20)

            attributedText.addAttribute(.font, value: boldFont, range: range)
            homePageTitle.attributedText = attributedText
        }
    
    func configureStraightLine() {
        straightLine.backgroundColor = UIColor(red: 147/255, green: 151/255, blue: 151/255, alpha: 1.0)
           straightLine.translatesAutoresizingMaskIntoConstraints = false
           contentView.addSubview(straightLine)
           NSLayoutConstraint.activate([
               straightLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
               straightLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
               straightLine.heightAnchor.constraint(equalToConstant: 1)
           ])
    }
    

}
