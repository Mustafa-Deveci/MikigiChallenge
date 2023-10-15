//
//  TimelineInsideCollectionViewCell.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 14.10.2023.
//

import UIKit

protocol TimelineInsideNavigateDelegate: AnyObject {
    func navigateFollowListPage()
}

public enum timelineInsideIdentifier {
    static let timelineInsideIdentifier = "TimelineInsideCollectionViewCell"
}

class TimelineInsideCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var timelineImageView: UIImageView!
    @IBOutlet weak var timelineTitle: UILabel!
    @IBOutlet weak var timelineDate: UILabel!
    @IBOutlet weak var timelineCountryCount: UILabel!
    
    @IBOutlet weak var followImageThree: UIImageView!
    @IBOutlet weak var followImageTwo: UIImageView!
    @IBOutlet weak var followImageOne: UIImageView!
    @IBOutlet weak var followInfo: UIImageView!
    
    weak var delegate: TimelineInsideNavigateDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBlurEffect()
        setGestureRecognizer()
    }
    func setGestureRecognizer(){
        let tapFollowImageOne = UITapGestureRecognizer(target: self, action: #selector(viewFollowInfo(sender:)))
        tapFollowImageOne.delegate = self
        followImageOne.addGestureRecognizer(tapFollowImageOne)
        
        let tapFollowImageTwo = UITapGestureRecognizer(target: self, action: #selector(viewFollowInfo(sender:)))
        tapFollowImageTwo.delegate = self
        followImageTwo.addGestureRecognizer(tapFollowImageTwo)
        
        let tapFollowImageThree = UITapGestureRecognizer(target: self, action: #selector(viewFollowInfo(sender:)))
        tapFollowImageThree.delegate = self
        followImageThree.addGestureRecognizer(tapFollowImageThree)
        
        let tapFollowInfo = UITapGestureRecognizer(target: self, action: #selector(viewFollowInfo(sender:)))
        tapFollowInfo.delegate = self
        followInfo.addGestureRecognizer(tapFollowInfo)
        
    }
    func setBlurEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = followInfo.bounds;
        followInfo.addSubview(blurView)
    }
    
    @objc func viewFollowInfo(sender: UITapGestureRecognizer) {
        self.delegate?.navigateFollowListPage()

    }
    
}
    


