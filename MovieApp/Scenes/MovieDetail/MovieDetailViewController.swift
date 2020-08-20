//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Can Kalender on 17.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import WebKit

class MovieDetailViewController:UIViewController{
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    private var movieDetail: MovieDetail? {
        didSet{
            setUI()
        }
    }
    
    var movieId: Int? {
        didSet{
            getDetails(movieId ?? 0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func setUI(){
        let poster_url = "https://image.tmdb.org/t/p/w500/"
        DispatchQueue.main.async {
            self.movieImageView.kf.setImage(with: URL(string: (poster_url + (self.movieDetail?.poster ?? "")) ))
            self.overviewLabel.text = self.movieDetail?.overview ?? ""
        }
    }

    // MARK: Service
    func getDetails(_ movieId : Int) {
        DispatchQueue.main.async {
            LoadingView.start(view: self.view)
        }
        NetworkManager.shared.getMovieDetail(movieId: movieId) { (movieDetailResponse, error) in
            DispatchQueue.main.async {
                LoadingView.stop(view: self.view)
            }
            self.movieDetail = movieDetailResponse
        }
    }
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        
        let trailerVideoController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrailerViewPlayer") as! TrailerViewPlayer
        trailerVideoController.movieId = movieId

//        self.navigationController?.pushViewController(trailerVideoController, animated: true)
        self.navigationController?.showDetailViewController(trailerVideoController, sender: nil)
    }
    
}
