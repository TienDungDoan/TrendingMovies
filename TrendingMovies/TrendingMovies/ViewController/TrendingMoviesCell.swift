//
//  TrendingMoviesCell.swift
//  TrendingMovies
//
//  Created by Tien Dung Doan on 04/10/2023.
//

import UIKit

class TrendingMoviesCell: UITableViewCell {
    
    @IBOutlet weak var moviesImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
