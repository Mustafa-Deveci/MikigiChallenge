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
    let timelineCountryCount: String?
    let timelineDate: String?
}

public struct MentionImageArguments {
    let mentionProfileImage: String?
}

public enum timelineIdentifier {
    static let timelineIdentifier = "TimelineCollectionViewCell"
}

class TimelineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var timelineInsideDelegate: TimelineInsideNavigateDelegate?

    private var timelineCardModel: [TimelineCardArguments] = []
    private var mentionModel: [MentionImageArguments] = []
    
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
    public func updateUIMentionCard(with model: [MentionImageArguments]) {
        self.mentionModel = model
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
          cell.indeks = indexPath.item
          cell.timelineImageView.setImage(with: timelineCardModel.timelineImageView)
          cell.timelineTitle.text = timelineCardModel.timelineTitle
          cell.timelineCountryCount.text = ("\(timelineCardModel.timelineCountryCount ?? "")")
          if let daysAgo = convertUnixTimestampToDaysAgo(timelineCardModel.timelineDate ?? "") {
              cell.timelineDate.text = daysAgo
          }
            switch indexPath.item {
            case 0:
                  let mentionCard1Model = mentionModel[0]
                  let mentionCard2Model = mentionModel[1]
                  let mentionCard3Model = mentionModel[2]
                  cell.followImageOne.setImage(with: mentionCard1Model.mentionProfileImage)
                  cell.followImageTwo.setImage(with: mentionCard2Model.mentionProfileImage)
                  cell.followImageThree.setImage(with: mentionCard3Model.mentionProfileImage)
            case 1:
                let mentionCard1Model = mentionModel[3]
                let mentionCard2Model = mentionModel[4]
                cell.followImageOne.setImage(with: mentionCard1Model.mentionProfileImage)
                cell.followImageTwo.setImage(with: mentionCard2Model.mentionProfileImage)
            case 2:
                let mentionCard1Model = mentionModel[5]
                cell.followImageOne.setImage(with: mentionCard1Model.mentionProfileImage)
            case 3:
                cell.followInfo.isHidden = true
                cell.plusIcon.isHidden = true
            case 4:
                let mentionCard1Model = mentionModel[6]
                let mentionCard2Model = mentionModel[7]
                let mentionCard3Model = mentionModel[8]
                cell.followImageOne.setImage(with: mentionCard1Model.mentionProfileImage)
                cell.followImageTwo.setImage(with: mentionCard2Model.mentionProfileImage)
                cell.followImageThree.setImage(with: mentionCard3Model.mentionProfileImage)
          default:
              break
          }
          cell.delegate = timelineInsideDelegate
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
          return .init(0)
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return .init(top: 0, left: 0, bottom: 0, right: 0)
      }
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          print("Clicked \(indexPath.item)")
      }

  }

extension TimelineCollectionViewCell {
    func convertUnixTimestampToDaysAgo(_ unixTimestampString: String) -> String? {
        if let unixTimestamp = Double(unixTimestampString) {
            let unixTimestampSecond = unixTimestamp / 1000
            let date = Date(timeIntervalSince1970: unixTimestampSecond)
            let currentDate = Date()
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.day], from: date, to: currentDate)
            if let days = dateComponents.day {
                return "\(days) Days Ago"
            }
        }
        return nil
    }
}


