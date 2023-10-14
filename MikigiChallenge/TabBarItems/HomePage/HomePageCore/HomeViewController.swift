//
//  HomeViewController.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 12.10.2023.
//

import UIKit
import Foundation
import Alamofire
import RxSwift

protocol HomeVCInterface: AnyObject {
    func reloadCollection()
    func setCollectionOwner()
    func setCollectionRegister()

}

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var viewModel: HomeViewModelInterface = HomeViewModel(view: self)
    let disposeBag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestData()
        viewModel.getFeaturedData()
        self.reloadCollection()
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionOwner()
        setCollectionRegister()
    }

}

// MARK: - HomeVCInterface Methods
extension HomeViewController: HomeVCInterface {
    // reload main thread
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    // delegate authority
    func setCollectionOwner() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func setCollectionRegister() {
        // Reusable cell
        collectionView.register(UINib(nibName: topItemsCollectionIdentifier.topItems, bundle: nil), forCellWithReuseIdentifier: topItemsCollectionIdentifier.topItems)
        collectionView.register(UINib(nibName: featuredIdentifier.featuredIdentifier, bundle: nil), forCellWithReuseIdentifier: featuredIdentifier.featuredIdentifier)
       
    }

}
// MARK: - UICollectionViewDataSource Methods
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection(section: section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topItemsCollectionIdentifier.topItems, for: indexPath) as? TopItemsCollectionViewCell else { return .init() }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featuredIdentifier.featuredIdentifier, for: indexPath) as? FeaturedCollectionViewCell else { return .init() }
            cell.updateUICircleCard(with: viewModel.featuredArguments)
            return cell
        default:
            return .init()
        }
    }
}
// MARK: - UICollectionViewDelegate Methods
extension HomeViewController: UICollectionViewDelegate {

}
// MARK: - UICollectionViewDelegateFlowLayout Methods
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.sizeForItemAt(index: indexPath, collection: self.collectionView)
    }
}


