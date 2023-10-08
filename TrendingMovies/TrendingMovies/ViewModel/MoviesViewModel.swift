//
//  MoviesViewModel.swift
//  TrendingMovies
//
//  Created by Tien Dung Doan on 03/10/2023.
//

import Foundation
import Alamofire

class MoviesViewModel {
    let apiKey = "47aa75b56464da7a186b813a50035cd4"
    
    func callApiToGetTrendingMovies(page: Int? = 1, completion: @escaping ([Movies]) -> Void, failure: @escaping (ApiError) -> Void) {
        //https://api.themoviedb.org/3/movie/popular?api_key=API_KEY&language=en-US&page=1
        
        let params: Parameters = ["api_key": apiKey, "page": page ?? 1]
        let config = DefaultRequestConfiguration(method: .get, path: "trending/movie/day", parameter: params)
        ApiClient.shared.performRequest(configuration: config) { json in
            completion(TrendingMovies(json: json).results)
        } failure: { err,_ in
            failure(err)
        }
        
        
    }
    
    func searchMovies(query: String, completion: @escaping ([Movies]) -> Void, failure: @escaping (ApiError) -> Void) {
        let params: Parameters = ["api_key": apiKey, "query": query]
        let config = DefaultRequestConfiguration(method: .get, path: "search/movie", parameter: params)
        ApiClient.shared.performRequest(configuration: config) { json in
            completion(TrendingMovies(json: json).results)
        } failure: { err,_ in
            failure(err)
        }
    }

    func getMovieDetail(id: Int, completion: @escaping (MovieDetail) -> Void, failure: @escaping (ApiError) -> Void) {
        let params: Parameters = ["api_key": apiKey]
        let config = DefaultRequestConfiguration(method: .get, path: "movie/\(id)", parameter: params)
        ApiClient.shared.performRequest(configuration: config) { json in
            completion(MovieDetail(json: json))
        } failure: { err,_ in
            failure(err)
        }
    }
    
}
