//
//  FollowListViewController.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 15.10.2023.
//

import UIKit
import RxSwift

public struct MentionArguments {
    let mentionId: String?
    let mentionProfileImage: String?
    let mentionFullname: String?
    let mentionUserName: String?
    let mentionisFollowing: Bool?
}

class FollowListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var navContoller: UINavigationController!
    var indeks: Int?
    private var mentionsModel: [MentionArguments] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FollowListTableViewCell.nib(), forCellReuseIdentifier: FollowListTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

    }
    func updateUIMentionsArg(with model: [MentionArguments]) {
        self.mentionsModel = model
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let indeks = indeks {
                switch indeks {
                case 0:
                    return 3
                case 1:
                    return 2
                case 2:
                    return 1
                case 3:
                    return 0
                case 4:
                    return 3
                default:
                    return 0
                }
            } else {
                return 0
            }
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowListTableViewCell", for: indexPath) as! FollowListTableViewCell
        
        if let indeks = indeks {
            let startIndex: Int

            switch indeks {
            case 0:
                startIndex = 0
            case 1:
                startIndex = 3
            case 2:
                startIndex = 5
            case 3:
                return cell
            case 4:
                startIndex = 6
            default:
                return cell
            }
            
            let dataIndex = startIndex + indexPath.row
            if dataIndex < mentionsModel.count {
                let mentionCardsModel = mentionsModel[dataIndex]
                configureCell(cell, with: mentionCardsModel)
            }
        }
        
        return cell
    }
    
      func configureCell(_ cell: FollowListTableViewCell, with mentionCardsModel: MentionArguments) {
          cell.popupName.text = mentionCardsModel.mentionFullname
          cell.popupUsername.text = mentionCardsModel.mentionUserName
          cell.popupImage.setImage(with: mentionCardsModel.mentionProfileImage)
          cell.isFollow = mentionCardsModel.mentionisFollowing ?? false
      }

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: false)
    }
    
}

