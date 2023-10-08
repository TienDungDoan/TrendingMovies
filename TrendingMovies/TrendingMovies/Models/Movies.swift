//
//  Movies.swift
//  Movies
//
//  Created by Tien Dung Doan on 03/10/2023.
//

import Foundation
import SwiftyJSON

class TrendingMovies: NSObject {
    var page: Int = 0
    var results: [Movies] = []
    var totalPages: Int = 0
    var totalResults: Int = 0
    
    init(json: JSON) {
        super.init()
        page = json["page"].intValue
        for movie in json["results"].arrayValue {
            results.append(Movies(json: movie))
        }
        totalPages = json["total_pages"].intValue
        totalResults = json["total_results"].intValue
    }
}

class Movies: NSObject {
    var adult: Bool = false
    var backdropPath: String?
    var id: Int = 0
    var originalLanguage: String = ""
    var originalTitle: String = ""
    var overview: String = ""
    var posterPath: String?
    var mediaType: String?
    var genreIds: [Int] = []
    var popularity: Double = 0
    var releaseDate: String = ""
    var video: Bool = false
    var voteAverage: Double = 0
    var voteCount: Int = 0
    var image: UIImage?
    
    init(json: JSON) {
        super.init()
        adult = json["page"].boolValue
        backdropPath = json["backdrop_path"].stringValue
        id = json["id"].intValue
        originalLanguage = json["original_language"].stringValue
        originalTitle = json["original_title"].stringValue
        overview = json["overview"].stringValue
        posterPath = json["poster_path"].stringValue
        mediaType = json["media_type"].stringValue
        for genre in json["genre_ids"].arrayValue {
            genreIds.append(genre.intValue)
        }
        popularity = json["popularity"].doubleValue
        releaseDate = json["release_date"].stringValue
        video = json["video"].boolValue
        voteAverage = json["vote_average"].doubleValue
        voteCount = json["vote_count"].intValue
    }
    
    init(adult: Bool, backdropPath: String?,
         id: Int, originalLanguage: String, originalTitle: String,
         overview: String, posterPath: String,
         mediaType: String, genreIds: [Int],
         popularity: Double, releaseDate: String,
         video: Bool, voteAverage: Double, voteCount: Int, image: UIImage? = nil) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.mediaType = mediaType
        self.genreIds = genreIds
        self.popularity = popularity
        self.releaseDate = releaseDate
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.image = image
    }
    
}

class MovieDetail: NSObject {
    var id: Int = 0
    var imdbId: String = ""
    var adult: Bool = false
    var backdropPath: String?
    var belongsToCollection: BelongToCollection?
    var budget: Int = 0
    var genres: [Genres] = []
    var homepage: String = ""
    var originalLanguage: String = ""
    var originalTitle: String = ""
    var overview: String = ""
    var popularity: Double = 0
    var posterPath: String = ""
    var productionCompanies: [ProductionCompanies] = []
    var productionCountries: [ProductionCountries] = []
    var releaseDate: String = ""
    var revenue: Int = 0
    var runtime: Int = 0
    var spokenLanguages: [SpokenLanguages] = []
    var status: String = ""
    var tagline: String = ""
    var title: String = ""
    var video: Bool = false
    var voteAverage: Double = 0
    var voteCount: Int = 0
    var image: UIImage?
    
    init(json: JSON) {
        id = json["id"].intValue
        imdbId = json["imdb_id"].stringValue
        adult = json["page"].boolValue
        backdropPath = json["backdrop_path"].stringValue
        belongsToCollection = BelongToCollection(json: json["belongs_to_collection"])
        budget = json["budget"].intValue
        for genre in json["genres"].arrayValue {
            genres.append(Genres(json: genre))
        }
        homepage = json["homepage"].stringValue
        originalLanguage = json["original_language"].stringValue
        originalTitle = json["original_title"].stringValue
        overview = json["overview"].stringValue
        popularity = json["popularity"].doubleValue
        posterPath = json["poster_path"].stringValue
        for productionCompany in json["production_companies"].arrayValue {
            productionCompanies.append(ProductionCompanies(json: productionCompany))
        }
        for productionCountry in json["production_countries"].arrayValue {
            productionCountries.append(ProductionCountries(json: productionCountry))
        }
        releaseDate = json["release_date"].stringValue
        revenue = json["revenue"].intValue
        runtime = json["runtime"].intValue
        for spokenLanguage in json["spoken_languages"].arrayValue {
            spokenLanguages.append(SpokenLanguages(json: spokenLanguage))
        }
        status = json["status"].stringValue
        tagline = json["tagline"].stringValue
        title = json["title"].stringValue
        video = json["video"].boolValue
        voteAverage = json["vote_average"].doubleValue
        voteCount = json["vote_count"].intValue
    }
    
    init(id: Int, imdbId: String, adult: Bool,
         backdropPath: String?, belongsToCollection: BelongToCollection?,
         budget: Int, genres: [Genres], homepage: String,
         originalLanguage: String, originalTitle: String,
         overview: String, popularity: Double, posterPath: String,
         productionCompanies: [ProductionCompanies], productionCountries: [ProductionCountries],
         releaseDate: String, revenue: Int, runtime: Int,
         spokenLanguages: [SpokenLanguages], status: String, tagline: String, title: String,
         video: Bool, voteAverage: Double, voteCount: Int, image: UIImage? = nil) {
        self.id = id
        self.imdbId = imdbId
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.image = image
    }
    
}

class BelongToCollection: NSObject {
    var id: Int = 0
    var name: String = ""
    var posterPath: String = ""
    var backdropPath: String?
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        posterPath = json["poster_path"].stringValue
        backdropPath = json["backdrop_path"].stringValue
    }
}

class Genres: NSObject {
    static var supportsSecureCoding: Bool = true
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
    }
    
    required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        let name = coder.decodeObject(forKey: "name") as? String ?? ""
        
        self.init(id: id, name: name)
    }
    
    var id: Int = 0
    var name: String = ""
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

class ProductionCompanies: NSObject {
    var id: Int = 0
    var name: String = ""
    var logoPath: String?
    var originCountry: String = ""
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        logoPath = json["logo_path"].stringValue
        originCountry = json["origin_country"].stringValue
    }
}

class ProductionCountries: NSObject {
    var iso31661: String = ""
    var name: String = ""
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name = "name"
    }
    
    init(json: JSON) {
        iso31661 = json["iso_3166_1"].stringValue
        name = json["name"].stringValue
    }
}

class SpokenLanguages: NSObject {
    var iso6391: String = ""
    var name: String = ""
    var englishName: String = ""
    
    init(json: JSON) {
        iso6391 = json["iso_639_1"].stringValue
        name = json["name"].stringValue
        englishName = json["english_name"].stringValue
    }
}
