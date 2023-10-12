//
//  NetworkConstants.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 12.10.2023.
//

import Foundation
import UIKit

struct NetworkConstant {
    
    //The API's base URL
    static let baseUrl = "http://challenge.mikigi.com:3099"
    static let deviceId = UIDevice.current.identifierForVendor?.uuidString
   
    //The parameters
    struct Parameters {
        static let id = "id"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
