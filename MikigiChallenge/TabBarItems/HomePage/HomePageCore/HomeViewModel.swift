//
//  HomeViewModel.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 12.10.2023.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol HomeViewModelInterface: AnyObject {
    func numberOfItemsInSection(section: Int) -> Int
    func sizeForItemAt(index: IndexPath, collection: UICollectionView) -> CGSize
    var numberOfSections: Int { get }
}

final class HomeViewModel {
    private weak var view: HomeVCInterface?
    private var disposeBag = DisposeBag()
    public init(view: HomeVCInterface = HomeViewController()) {
        self.view = view
    }
}
// MARK: - HomeViewModelInterface
extension HomeViewModel: HomeViewModelInterface {
    var numberOfSections: Int {
        return 2
    }
    func numberOfItemsInSection(section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 1
        }
    }
    func sizeForItemAt(index: IndexPath, collection: UICollectionView) -> CGSize {
        switch index.section {
        case 0:
            return .init(width: collection.frame.width, height: 80)
        case 1:
            return .init(width: collection.frame.width, height: 300)
        default:
            return .init()
        }
    }
    
}



