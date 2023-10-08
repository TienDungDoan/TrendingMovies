//
//  MagicalRecordHelper.swift
//  TrendingMovies
//
//  Created by Tien Dung Doan on 06/10/2023.
//

import Foundation
import MagicalRecord

class MagicalRecordHelper {
    
    static var shared = MagicalRecordHelper()
    
    func saveTrendingMovieValues(_ values: [Movies], completion: (() -> ())? = nil) {
        MagicalRecord.save { context in
            values.forEach { (value) in
                let entity = MoviesEntity.mr_createEntity(in: context)
                entity?.adult = value.adult
                entity?.backdropPath = value.backdropPath
                entity?.id = Int32(value.id)
                entity?.originalLanguage = value.originalLanguage
                entity?.originalTitle = value.originalTitle
                entity?.overview = value.overview
                entity?.posterPath = value.posterPath
                entity?.mediaType = value.mediaType
                entity?.genreIds = value.genreIds.reduce("") {retVal, value in retVal + String(value) + "," }
                entity?.popularity = value.popularity
                entity?.releaseDate = value.releaseDate
                entity?.video = value.video
                entity?.voteAverage = value.voteAverage
                entity?.voteCount = Int16(value.voteCount)
                entity?.image = value.image
            }
        } completion: { (_, _) in
            completion?()
        }
    }
    
    func saveImageInTrendingMovie(id: Int, image: UIImage, completion: (() -> ())? = nil) {
        MagicalRecord.save { context in
            let entity = MoviesEntity.mr_findFirstOrCreate(byAttribute: "id", withValue: id, in: context)
            entity.image = image
        } completion: { (_, _) in
            completion?()
        }
        
    }
    
    func fetchTrendingMovieValues() -> [Movies] {
        if let values = MoviesEntity.mr_findAll() as? [MoviesEntity] {
            return values.compactMap { movie in
                let genresNum = (movie.genreIds ?? "").components(separatedBy: ",").compactMap({ Int($0) })
                return Movies(adult: movie.adult, backdropPath: movie.backdropPath,
                              id: Int(movie.id), originalLanguage: movie.originalLanguage ?? "", originalTitle: movie.originalTitle ?? "",
                              overview: movie.overview ?? "", posterPath: movie.posterPath ?? "",
                              mediaType: movie.mediaType ?? "", genreIds: genresNum,
                              popularity: movie.popularity, releaseDate: movie.releaseDate ?? "",
                              video: movie.video, voteAverage: movie.voteAverage, voteCount: Int(movie.voteCount), image: movie.image)
            }
        }
        return []
    }
    
    func deleteAllTrendingMovieValues() {
        if let values = MoviesEntity.mr_findAll() as? [MoviesEntity] {
            MagicalRecord.save { context in
                values.forEach { value in
                    value.mr_deleteEntity(in: context)
                }
            } completion: { (_, _) in
                //do nothing
            }
        }
    }
    
    func saveMoviesDetailValue(_ value: MovieDetail, completion: (() -> ())? = nil) {
        MagicalRecord.save { context in
            let entity = MoviesDetailEntity.mr_createEntity(in: context)
            entity?.id = Int32(value.id)
            entity?.imdbId = value.imdbId
            entity?.adult = value.adult
            entity?.backdropPath = value.backdropPath
            entity?.belongsToCollection = value.belongsToCollection
            entity?.budget = Int32(value.budget)
            entity?.genres = value.genres
            entity?.homepage = value.homepage
            entity?.originalLanguage = value.originalLanguage
            entity?.originalTitle = value.originalTitle
            entity?.overview = value.overview
            entity?.popularity = value.popularity
            entity?.posterPath = value.posterPath
            entity?.productionCompanies = value.productionCompanies
            entity?.productionCountries = value.productionCountries
            entity?.releaseDate = value.releaseDate
            entity?.revenue = Int32(value.revenue)
            entity?.runtime = Int32(value.runtime)
            entity?.spokenLanguages = value.spokenLanguages
            entity?.status = value.status
            entity?.tagline = value.tagline
            entity?.title = value.title
            entity?.video = value.video
            entity?.voteAverage = value.voteAverage
            entity?.voteCount = Int32(value.voteCount)
            entity?.image = value.image
        } completion: { (_, _) in
            completion?()
        }
    }
    
    func saveImageInMovieDetail(id: Int, image: UIImage, completion: (() -> ())? = nil) {
        MagicalRecord.save { context in
            let entity = MoviesDetailEntity.mr_findFirstOrCreate(byAttribute: "id", withValue: id, in: context)
            entity.image = image
        } completion: { (_, _) in
            completion?()
        }
        
    }
    
    func fetchMovieDetailValue() -> [MovieDetail] {
        if let values = MoviesDetailEntity.mr_findAll() as? [MoviesDetailEntity] {
            return values.compactMap { movie in
                return MovieDetail(id: Int(movie.id), imdbId: movie.imdbId ?? "", adult: movie.adult,
                                   backdropPath: movie.backdropPath, belongsToCollection: movie.belongsToCollection,
                                   budget: Int(movie.budget), genres: movie.genres ?? [], homepage: movie.homepage ?? "",
                                   originalLanguage: movie.originalLanguage ?? "", originalTitle: movie.originalTitle ?? "",
                                   overview: movie.overview ?? "", popularity: movie.popularity, posterPath: movie.posterPath ?? "",
                                   productionCompanies: movie.productionCompanies ?? [], productionCountries: movie.productionCountries ?? [],
                                   releaseDate: movie.releaseDate ?? "", revenue: Int(movie.revenue), runtime: Int(movie.runtime),
                                   spokenLanguages: movie.spokenLanguages ?? [], status: movie.status ?? "", tagline: movie.tagline ?? "",
                                   title: movie.title ?? "", video: movie.video, voteAverage: movie.voteAverage, voteCount: Int(movie.voteCount), image: movie.image)
            }
        }
        return []
    }
    
    func findMovieDetailById(id: Int) -> MovieDetail? {
        if let entity = MoviesDetailEntity.mr_findFirst(byAttribute: "id", withValue: id) {
            return MovieDetail(id: Int(entity.id), imdbId: entity.imdbId ?? "", adult: entity.adult,
                               backdropPath: entity.backdropPath, belongsToCollection: entity.belongsToCollection,
                               budget: Int(entity.budget), genres: entity.genres ?? [], homepage: entity.homepage ?? "",
                               originalLanguage: entity.originalLanguage ?? "", originalTitle: entity.originalTitle ?? "",
                               overview: entity.overview ?? "", popularity: entity.popularity, posterPath: entity.posterPath ?? "",
                               productionCompanies: entity.productionCompanies ?? [], productionCountries: entity.productionCountries ?? [],
                               releaseDate: entity.releaseDate ?? "", revenue: Int(entity.revenue), runtime: Int(entity.runtime),
                               spokenLanguages: entity.spokenLanguages ?? [], status: entity.status ?? "", tagline: entity.tagline ?? "",
                               title: entity.title ?? "", video: entity.video, voteAverage: entity.voteAverage, voteCount: Int(entity.voteCount), image: entity.image)
        }
        return nil
    }
}
