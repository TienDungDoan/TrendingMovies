//
//  MoviesDetailEntity+CoreDataProperties.swift
//  TrendingMovies
//
//  Created by Tien Dung Doan on 08/10/2023.
//
//

import Foundation
import CoreData
import UIKit


extension MoviesDetailEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviesDetailEntity> {
        return NSFetchRequest<MoviesDetailEntity>(entityName: "MoviesDetailEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var imdbId: String?
    @NSManaged public var adult: Bool
    @NSManaged public var backdropPath: String?
    @NSManaged var belongsToCollection: BelongToCollection?
    @NSManaged public var budget: Int32
    @NSManaged public var homepage: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged var productionCompanies: [ProductionCompanies]?
    @NSManaged var productionCountries: [ProductionCountries]?
    @NSManaged public var releaseDate: String?
    @NSManaged public var revenue: Int32
    @NSManaged public var runtime: Int32
    @NSManaged var spokenLanguages: [SpokenLanguages]?
    @NSManaged public var status: String?
    @NSManaged public var tagline: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int32
    @NSManaged var genres: [Genres]?
    @NSManaged public var image: UIImage?
}

extension MoviesDetailEntity : Identifiable {

}
