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
    static func getTimeline(page: Int) -> Observable<GetTimelineModel>
    //func viewDidLoad()
    func FeaturedRequestData()
    func TimelineRequestData(page: Int)
    func getFeaturedData()
    func getTimelineData()
    func numberOfItemsInSection(section: Int) -> Int
    func sizeForItemAt(index: IndexPath, collection: UICollectionView) -> CGSize
    
    var homepageFeaturedList: PublishSubject<GetFeaturedModel> { get set }
    var homepageTimelineList: PublishSubject<GetTimelineModel> { get set }
    var featuredModel: [Featured] { get set }
    var featuredArguments: [FeaturedCardArguments] { get set }
    var timelineModel: [Timeline] { get set }
    var timelineArguments: [TimelineCardArguments] { get set }
    var numberOfSections: Int { get }
}

final class HomeViewModel {
    private weak var view: HomeVCInterface?
    private var disposeBag = DisposeBag()
    
    public var homepageFeaturedList: PublishSubject<GetFeaturedModel> = PublishSubject()
    
    public var featuredModel: [Featured] = []
    public var featuredArguments: [FeaturedCardArguments] = []
    
    public var homepageTimelineList: PublishSubject<GetTimelineModel> = PublishSubject()
    public var timelineModel: [Timeline] = []
    public var timelineArguments: [TimelineCardArguments] = []
    
    public init(view: HomeVCInterface = HomeViewController()) {
        self.view = view
    }
}
// MARK: - HomeViewModelInterface
extension HomeViewModel: HomeViewModelInterface {
    var numberOfSections: Int {
        return 3
    }
    func numberOfItemsInSection(section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 1
        }
    }
    func sizeForItemAt(index: IndexPath, collection: UICollectionView) -> CGSize {
        switch index.section {
        case 0:
            return .init(width: collection.frame.width, height: 60)
        case 1:
            return .init(width: collection.frame.width - 40, height: 300)
        case 2:
            return .init(width: collection.frame.width - 40, height: 1100)
        default:
            return .init()
        }
    }
    static func getFeatured() -> Observable<GetFeaturedModel> {
        return ApiClient.request(ApiRouter.getFeatured)
    }
    static func getTimeline(page: Int) -> Observable<GetTimelineModel> {
        return ApiClient.request(ApiRouter.getTimeline(page: page))
    }
    func FeaturedRequestData() {
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
    func TimelineRequestData(page: Int) {
        HomeViewModel.getTimeline(page: page)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { results in
                self.homepageTimelineList.onNext(results)
                print("List of posts:", results)
            }, onError: { error in
                switch error {
                case ApiError.conflict:
                    print("Conflict error")
                case ApiError.forbidden:
                    print("Forbidden error")
                case ApiError.notFound:
                    print("Not found error")
                default:
                    print("List of posts:", error)
                 print("Unknown error:", error.localizedDescription)
                }
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
    func getTimelineData() {
        self.homepageTimelineList.observe(on: MainScheduler.asyncInstance).subscribe { [weak self] event in
            guard let self = self else { return }
            if let response = event.element {
                self.timelineModel = response.timeline
                self.timelineArguments.removeAll()
                for timelineContent in self.timelineModel {
                    guard let timelineContentId = timelineContent.id,
                          let timelineImageUrl = timelineContent.imageURL,
                          let timelineTitle = timelineContent.title,
                          let timelineCountryStruct = timelineContent.countryCount,
                          let timelineDate = timelineContent.date
                    else { return }
                    let timelineCountryCount = ("\(timelineCountryStruct) COUNTRIES")
                    let arguments = TimelineCardArguments(timelineId: timelineContentId, timelineImageView: timelineImageUrl, timelineTitle: timelineTitle, timelineCountryCount: timelineCountryCount, timelineDate: timelineDate)
                    timelineArguments.append(arguments)

                }
                self.timelineArguments = timelineArguments
                self.view?.reloadCollection()

            }

        }
    }
}



