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
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}
