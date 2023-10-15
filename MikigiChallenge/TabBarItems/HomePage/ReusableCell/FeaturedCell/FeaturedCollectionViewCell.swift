//
//  FeaturedCollectionViewCell.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 12.10.2023.
//

import UIKit
import SDWebImage

public struct FeaturedCardArguments {
    let featuredImageView: String?
    let featuredCityLabel: String?
    let featuredId: String?
    let featuredCountryLabel: String?
}

public enum featuredIdentifier {
    static let featuredIdentifier = "FeaturedCollectionViewCell"
}

class FeaturedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homeSubtitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private var featuredCardModel: [FeaturedCardArguments] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionOwner()
        setRegister()

    }
    
    private func setCollectionOwner() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func setRegister() {
        collectionView.register(UINib(nibName: featuredInsideIdentifier.featuredInsideIdentifier, bundle: nil), forCellWithReuseIdentifier: featuredInsideIdentifier.featuredInsideIdentifier)
    }
    private func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    public func updateUICircleCard(with model: [FeaturedCardArguments]) {
        self.featuredCardModel = model
        reloadCollection()
    }

}

// MARK: - UICollectionViewDataSource
extension FeaturedCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredCardModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featuredInsideIdentifier.featuredInsideIdentifier, for: indexPath) as! FeaturedInsideCollectionViewCell
        let featuredCardModel = featuredCardModel[indexPath.item]
        cell.featuredImageView.setImage(with: featuredCardModel.featuredImageView)
        cell.featuredCityLabel.text = featuredCardModel.featuredCityLabel
        cell.featuredCountryLabel.text = featuredCardModel.featuredCountryLabel
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension FeaturedCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 150, height: 230)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .init(12)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .init(12)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftInset = calculateLeftInsetForCollectionView()
        return .init(top: 0, left: leftInset, bottom: 0, right: 20)
    }
    private func calculateLeftInsetForCollectionView() -> CGFloat {
        let collectionViewWidth = collectionView.bounds.width
        let totalCellWidth = 100 * CGFloat(5)
        let leftInset = (collectionViewWidth - totalCellWidth) / 2
        return max(leftInset, 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Clicked \(indexPath.item)")
    }
}

extension UIImageView {
    func setImage(with urlString: String?) {
        guard let urlString = urlString else { return }
        let url = URL(string: urlString)
        self.sd_setImage(with: url)
        self.sd_imageTransition = .fade
    }
}
