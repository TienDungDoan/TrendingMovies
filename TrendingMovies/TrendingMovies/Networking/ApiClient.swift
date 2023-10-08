//
//  ApiClient.swift
//  TrendingMovies
//
//  Created by Tien Dung Doan on 03/10/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiClient {
    static let shared = ApiClient()
    let baseURL = "https://api.themoviedb.org/3/"
    
    func performRequest(configuration: DefaultRequestConfiguration, isShowIndicator: Bool = true, success: @escaping (JSON) -> Void, failure: @escaping (ApiError, JSON?) -> Void) {
        /// Do Common setting for requests
        // Check Internet connection
        guard _checkInternetAccess() == true else {
            let error = ApiError.InternetConnection(ApiErrorCode.NoConnection.rawValue)
            failure(error, nil)
            _handleCommonNetworkError(error: error)
            print("Cannot access internet")
            return
        }
        
        // Build URLs
        guard let url = buildAPIURL(for: configuration.path) else {
            let error = ApiError.InternalError(1)
            failure(error, nil)
            _handleCommonNetworkError(error: error)
            print("Build Request URL")
            return
        }
        
        // Headers
        var headers = _defaultClientHeader()
        if let _header = configuration.header {
            headers = _header
        }
        
        // Headers authentication
        if let credentials = configuration.credentials {
            // add credentials headers
            guard credentials.isExpired == false else {
                let error = ApiError.Unauthorized("Unknow")
                failure(error, nil)
                _handleCommonNetworkError(error: error)
                print("Session Expire")
                return
            }
            headers.add(name: HTTPHeaderField.Authentication.rawValue, value: HTTPHeaderField.Bearer.rawValue + " " + credentials.accessToken)
        }
        
        // Encoding parameter
        var encoding: ParameterEncoding = URLEncoding(destination: .methodDependent, arrayEncoding: .brackets, boolEncoding: .literal)
        if configuration.method == .get && configuration.isQueryParam {
            encoding = URLEncoding.queryString
        }
        
        // Custom encoding
        if let _encoding = configuration.encoding {
            encoding = _encoding
        }
        
        // Log request
        print("=====>Request_API----------------------------------------------------------------------------")
        print("URL: " + url.description)
        print("Headers: " + headers.description)
//        if isShowIndicator {
//            Helper.showLoading()
//        }
        let client = AF.request(url, method: configuration.method, parameters: configuration.parameters, encoding: encoding, headers: headers)
        
        
        client.responseData { (response) in
//            if isShowIndicator {
//                Helper.dismissLoading()
//            }
            
//            #if DEBUG
//            if let data = response.data, let string = String(data: data, encoding: .utf8) {
//                print(string)
//            }
//            #endif
            
            switch response.result {
            case .success(let data):
                if let jsonData = self.checkJson(data: data) {
                    success(JSON(jsonData))
                } else {
                    failure(ApiError.UnKnown, nil)
                }
            case .failure(let error):
                if let data = response.data, let jData = self.checkJson(data: data) {
                    failure(ApiError.UnKnown, JSON(jData))
                } else {
                    failure(ApiError.UnKnown, nil)
                }
            }
        }
    }
    
    func buildAPIURL(for urlComponentString: String) -> URL? {
        do {
            var baseURl: URL? = try baseURL.asURL()
            baseURl = URL(string: baseURl?.appendingPathComponent(urlComponentString).absoluteString.removingPercentEncoding ?? "") ?? nil
            return baseURl
        } catch {
            return nil
        }
    }
    
    func checkJson(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        } catch {
            return nil
        }
    }
    
    private func _defaultClientHeader() -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(name: HTTPHeaderField.ContentType.rawValue, value: ContentType.Json.rawValue)
        headers.add(name: HTTPHeaderField.AcceptType.rawValue, value: AcceptType.Json.rawValue)
        
        return headers
    }
    
    private func _checkInternetAccess() -> Bool{
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? false
    }
    
    private func _handleCommonNetworkError(error: ApiError){
        switch error {
        case .InternetConnection(let message):
//            Helper.displayAlert(with: message)
            break
        case .Unauthorized(let message):
//            Helper.displayAlert(message: message)
            break
        default:
            break
        }
        
    }
}

enum HTTPHeaderField: String {
    case Authentication = "Authorization"
    case ContentType = "Content-Type"
    case AcceptType = "Accept"
    case AcceptEncoding = "Accept-Encoding"
    case String = "String"
    case Bearer = "Bearer"
    case Charset = "charset"
    case DeviceId = "deviceid"
}

enum ContentType: String {
    case Json = "application/json"
    case Form = "application/x-www-form-urlencoded"
    case png = "image/png"
    case jpeg = "image/jpeg"
}
enum AcceptType: String {
    case Json = "application/json"
    case All = "*/*"
}

extension Optional where Wrapped == Int {
    var unwrap: Int {
        return self ?? 0
    }
}
