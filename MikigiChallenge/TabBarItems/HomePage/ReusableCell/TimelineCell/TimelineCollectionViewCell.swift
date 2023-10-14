//
//  TimelineCollectionViewCell.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 14.10.2023.
//

import UIKit

public struct TimelineCardArguments {
    let timelineId: String?
    let timelineImageView: String?
    let timelineTitle: String?
    let timelineCountryCount: Int?
    let timelineDate: String?
}

public enum timelineIdentifier {
    static let timelineIdentifier = "TimelineCollectionViewCell"
}

class TimelineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var timelineCardModel: [TimelineCardArguments] = []
      
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
          collectionView.register(UINib(nibName: timelineInsideIdentifier.timelineInsideIdentifier, bundle: nil), forCellWithReuseIdentifier: timelineInsideIdentifier.timelineInsideIdentifier)
      }
      private func reloadCollection() {
          DispatchQueue.main.async {
              self.collectionView.reloadData()
          }
      }
      public func updateUICircleCard(with model: [TimelineCardArguments]) {
          self.timelineCardModel = model
          reloadCollection()
      }

  }

  // MARK: - UICollectionViewDataSource
  extension TimelineCollectionViewCell: UICollectionViewDataSource {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return timelineCardModel.count
      }
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: timelineInsideIdentifier.timelineInsideIdentifier, for: indexPath) as! TimelineInsideCollectionViewCell
          let timelineCardModel = timelineCardModel[indexPath.item]
          cell.timelineImageView.setImage(with: timelineCardModel.timelineImageView)
          cell.timelineTitle.text = timelineCardModel.timelineTitle
          cell.timelineCountryCount.text = ("\(timelineCardModel.timelineCountryCount ?? .zero)")
          cell.timelineDate.text = timelineCardModel.timelineDate
          return cell
      }
  }
  // MARK: - UICollectionViewDelegateFlowLayout
  extension TimelineCollectionViewCell: UICollectionViewDelegateFlowLayout {
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return .init(width: collectionView.frame.width, height: 200)
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

