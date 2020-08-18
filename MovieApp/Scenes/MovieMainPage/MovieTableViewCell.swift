//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Can Kalender on 16.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    let poster_url = "https://image.tmdb.org/t/p/w200/"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()

//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        let margins = UIEdgeInsets(top: 0, left: 8, bottom: 10, right: 8)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    
    func setUI(_ movie: Movie){
        DispatchQueue.main.async {
            self.movieImageView.kf.setImage(with: URL(string: (self.poster_url + (movie.poster ?? "")) ))
            self.titleLabel.text = movie.title
            self.overviewLabel.text = movie.overview
            self.dateLabel.text = movie.year
        }
    }
    
    
}
