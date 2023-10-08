//
//  TrendingMoviesViewController.swift
//  TrendingMovies
//
//  Created by Tien Dung Doan on 03/10/2023.
//

import UIKit

class TrendingMoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextfield: UITextField!
    
    private lazy var viewModel: MoviesViewModel = {
        return MoviesViewModel()
    }()
    private var datasource: [Movies] = []
    var lastPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "TrendingMoviesCell", bundle: nil), forCellReuseIdentifier: "TrendingMoviesCell")

        searchTextfield.delegate = self
        loadMore()
    }
    
    

    private func loadMore() {
        lastPage += 1
        viewModel.callApiToGetTrendingMovies(page: lastPage) { [weak self] movies in
            guard let `self` = self else { return }
            guard movies.count > 0 else { return }
            self.datasource.append(contentsOf: movies)
            MagicalRecordHelper.shared.deleteAllTrendingMovieValues()
            MagicalRecordHelper.shared.saveTrendingMovieValues(self.datasource)
            self.tableView.reloadData()
        } failure: { err in
            switch err {
            case .InternetConnection(99999):
                self.datasource = MagicalRecordHelper.shared.fetchTrendingMovieValues()
                self.tableView.reloadData()
            default:
                break
            }
        }
    }
}

extension TrendingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingMoviesCell", for: indexPath) as? TrendingMoviesCell else { return UITableViewCell() }
        cell.titleLabel.text = datasource[indexPath.row].originalTitle
        cell.voteAverageLabel.text = String(datasource[indexPath.row].voteAverage)
        cell.releaseDateLabel.text = Date.dateFromString(for: datasource[indexPath.row].releaseDate).getYear()
        
        if let img = datasource[indexPath.row].image {
            cell.moviesImageView.image = img
        } else if let url = URL(string: "https://www.themoviedb.org/t/p/original\(datasource[indexPath.row].posterPath ?? "")") {
            cell.moviesImageView.load(url: url) { image in
                MagicalRecordHelper.shared.saveImageInTrendingMovie(id: self.datasource[indexPath.row].id, image: image)
            }
        }
        if indexPath.row == datasource.count - 1 {
            loadMore()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        func moveToMovieDetailViewController(_ movie: MovieDetail) {
            let movieDetailVC = UIStoryboard.movieDetailViewController()
            movieDetailVC.movie = movie
            MagicalRecordHelper.shared.saveMoviesDetailValue(movie)
            self.present(movieDetailVC, animated: true)
        }
        
        viewModel.getMovieDetail(id: datasource[indexPath.row].id) { movie in
            moveToMovieDetailViewController(movie)
        } failure: { [weak self] err in
            guard let `self` = self else { return }
            switch err {
            case .InternetConnection(99999):
                if let movie = MagicalRecordHelper.shared.findMovieDetailById(id: self.datasource[indexPath.row].id) {
                    moveToMovieDetailViewController(movie)
                }
            default:
                break
            }
        }

    }
}

extension TrendingMoviesViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            DispatchQueue.main.async {
                self.lastPage = 0
                self.loadMore()
            }
        }
            
        viewModel.searchMovies(query: textField.text ?? "") { [weak self] movies in
            guard let `self` = self else { return }
            self.datasource = movies
            self.tableView.reloadData()
        } failure: { err in
            print(err)
        }
    }
}

extension UIImageView {
    func load(url: URL,  completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion(image)
                    }
                }
            }
        }
    }
}

extension Date {
    static func dateFromString(for strDate: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        if let date = dateFormater.date(from: strDate) {
            return date
        }
        return Date()
    }
    
    func getYear() -> String {
        let myCalendar = Calendar(identifier: .gregorian)
        return String(myCalendar.component(.year, from: self))
    }
}
