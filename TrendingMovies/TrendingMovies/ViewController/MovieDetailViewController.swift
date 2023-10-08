//
//  MovieDetailViewController.swift
//  TrendingMovies
//
//  Created by Tien Dung Doan on 05/10/2023.
//

import UIKit

extension UIStoryboard  {
    
    static func storyboard(_ name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: Bundle.main)
    }
    
    static func movieDetailViewController() -> MovieDetailViewController {
        return UIStoryboard.storyboard("Movies").instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
    }
}

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idmb: UILabel!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var originalLanguage: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    
    var movie: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        guard let movie = movie else { return }
        
        idmb.text = "IDMB: " + movie.imdbId
        titleMovie.text = "Title: " + movie.title
        originalLanguage.text = "Languge: " + movie.originalLanguage
        releaseDate.text = "Date: " + movie.releaseDate
        voteAverage.text = "Vote: " + String(movie.voteAverage)
        
        
        if let img = movie.image {
            imageView.image = img
        } else if let url = URL(string: "https://www.themoviedb.org/t/p/original\(movie.posterPath)") {
            imageView.load(url: url) { image in
                MagicalRecordHelper.shared.saveImageInMovieDetail(id: movie.id, image: image)
            }
        }
        
    }
}
