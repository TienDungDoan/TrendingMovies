//
//  ApiError.swift
//  TrendingMovies
//
//  Created by Tien Dung Doan on 03/10/2023.
//

import Foundation

enum ApiError: Error {
    case InternalError(Int)
    case CommonError(Int)
    case InternetConnection(Int)
    case Unauthorized(String)
    case UnKnown
}

enum ApiErrorCode: Int {
    case InvalidEndpoint = 1
    case Other = 2
    case RequestError
    case DataError
    case NoConnection = 99999
}

struct ApiErrorResponse: Codable {
    let error: ApiErrorModel
}

struct ApiErrorModel: Codable {
    let code: Int?
    let message: String
}


struct ApiErrorStatusCode {
    static let DATA_NOT_FOUND = 140
    static let USER_TAG_NOT_EXIST = 160
    static let ACCESS_TOKEN_EXPIRED = 130
    static let FORCE_LOGOUT_BY_RESET_PWD = 450
    static let CHANGE_LOGIN_ID_CODE = 470
    static let DELETE_ACCOUNT_CODE = 460
    
    
}
