//
//  MoviesEntity+CoreDataProperties.swift
//  TrendingMovies
//
//  Created by Tien Dung Doan on 08/10/2023.
//
//

import Foundation
import CoreData
import UIKit


extension MoviesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviesEntity> {
        return NSFetchRequest<MoviesEntity>(entityName: "MoviesEntity")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdropPath: String?
    @NSManaged public var genreIds: String?
    @NSManaged public var id: Int32
    @NSManaged public var mediaType: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int16
    @NSManaged public var image: UIImage?

}

extension MoviesEntity : Identifiable {

}
