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
    static func getFeatured() -> Observable<GetFeaturedModel>
    //static func getTimelineModel() -> Observable<GetTimelineModel>
    //func viewDidLoad()
    func requestData()
    func getFeaturedData()
    func numberOfItemsInSection(section: Int) -> Int
    func sizeForItemAt(index: IndexPath, collection: UICollectionView) -> CGSize
    
    var homepageFeaturedList: PublishSubject<GetFeaturedModel> { get set }
    var featuredModel: [Featured] { get set }
    var featuredArguments: [FeaturedCardArguments] { get set }
   // var timelineArguments: [timelineCellArguments] { get set }
    var numberOfSections: Int { get }
}

final class HomeViewModel {
    private weak var view: HomeVCInterface?
    private var disposeBag = DisposeBag()
    
    public var homepageFeaturedList: PublishSubject<GetFeaturedModel> = PublishSubject()
    public var featuredModel: [Featured] = []
    public var featuredArguments: [FeaturedCardArguments] = []
    
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
            return .init(width: collection.frame.width, height: 350)
        default:
            return .init()
        }
    }
    static func getFeatured() -> Observable<GetFeaturedModel> {
        return ApiClient.request(ApiRouter.getFeatured)
    }
    func requestData() {
        HomeViewModel.getFeatured()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] results in
                guard let self = self else { return }
                self.homepageFeaturedList.onNext(results)
                print("List of posts:", results)
            }, onError: { error in
                print("Error")
            })
            .disposed(by: disposeBag)
    }
    func getFeaturedData() {
        self.homepageFeaturedList.observe(on: MainScheduler.asyncInstance).subscribe { [weak self] event in
            guard let self = self else { return }
            if let response = event.element {
                self.featuredModel = response.featured
                self.featuredArguments.removeAll()
                for featuredContent in self.featuredModel {
                    guard let featuredContentId = featuredContent.id,
                          let featuredImageUrl = featuredContent.imageURL,
                          let featuredCity = featuredContent.city,
                          let featuredCountry = featuredContent.country
                    else { return }
                    let arguments = FeaturedCardArguments(featuredImageView: featuredImageUrl, featuredCityLabel: featuredCity, featuredId: featuredContentId, featuredCountryLabel: featuredCountry)
                    featuredArguments.append(arguments)

                }
                self.featuredArguments = featuredArguments
                self.view?.reloadCollection()

            }
            
        }
    }
}



