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

class FollowListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var navContoller: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

