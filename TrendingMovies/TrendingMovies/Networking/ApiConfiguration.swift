//
//  ApiConfiguration.swift
//  TrendingMovies
//
//  Created by Tien Dung Doan on 03/10/2023.
//

import Foundation
import Alamofire

class DefaultRequestConfiguration {
    var method: HTTPMethod
    var path: String
    var parameters: Parameters?
    var credentials: DefaultCredentials?
    var isQueryParam : Bool = true // Default for get method
    var header : HTTPHeaders?
    var encoding: ParameterEncoding?
    
    init(method: HTTPMethod, path: String, parameter: Parameters? = nil, header: HTTPHeaders? = nil, encoding: ParameterEncoding? = nil) {
        self.method = method
        self.path = path
        self.parameters = parameter
        self.header = header
        self.encoding = encoding
    }
}
