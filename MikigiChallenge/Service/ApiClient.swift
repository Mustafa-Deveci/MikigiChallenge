//
//  ApiClient.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 12.10.2023.
//

import Foundation
import RxSwift
import Alamofire

class ApiClient {

    //MARK: - The request function to get results in an Observable
    static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible).responseDecodable(emptyResponseCodes: [200, 204, 205]) { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    print("Hata Mesajı: \(error.localizedDescription)") // Hatanın ayrıntılı açıklamasını yazdır
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}


