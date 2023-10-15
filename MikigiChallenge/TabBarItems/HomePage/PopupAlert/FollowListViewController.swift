//
//  FollowListViewController.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 15.10.2023.
//

import UIKit
import RxSwift

protocol FollowListDelegate: AnyObject {
    func reloadData()
}

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
    private var mentionsModel: [MentionArguments] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FollowListTableViewCell.nib(), forCellReuseIdentifier: FollowListTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
 
    }
    
    func updateUIMentionsArg(with model: [MentionArguments]) {
        self.mentionsModel = model
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentionsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowListTableViewCell", for: indexPath) as! FollowListTableViewCell
        let mentionCardsModel = mentionsModel[indexPath.row]
        cell.popupName.text = mentionCardsModel.mentionFullname
        cell.popupUsername.text = mentionCardsModel.mentionUserName
        cell.popupImage.setImage(with: mentionCardsModel.mentionProfileImage)
        return cell
    }
    


    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

