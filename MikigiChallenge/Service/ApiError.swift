//
//  ApiError.swift
//  MikigiChallenge
//
//  Created by mustafa deveci on 14.10.2023.
//

import Foundation

import Foundation

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
    case unAuthorized
}
