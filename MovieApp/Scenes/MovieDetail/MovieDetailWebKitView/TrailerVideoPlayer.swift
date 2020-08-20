//
//  TrailerVideoPlayer.swift
//  MovieApp
//
//  Created by Can Kalender on 19.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//

import UIKit
import WebKit
import AVKit

final class TrailerViewPlayer:UIViewController,UIWebViewDelegate{
    
    
    @IBOutlet weak var webView: WKWebView!
    private var movieTrailer: [MovieTrailer] = [] {
        didSet {
            setUI()
        }
    }
    var movieId: Int? {
        didSet{
            getTrailers(movieId ?? 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUI(){
        var videoID = String()
        movieTrailer.map({(resultObject) in
            print("key.key",resultObject.key)
            if resultObject.type == "Trailer"{
                videoID = resultObject.key ?? ""
            }
            
        })
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        print("youtubeURL",youtubeURL)
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: youtubeURL))
        }
    }
    
    
    
    func getTrailers(_ movieId : Int) {
        DispatchQueue.main.async {
            LoadingView.start(view: self.view)
        }
        NetworkManager.shared.getMovieTrailer(movieId: movieId) { (movieTrailerResponse, error) in
            
            self.movieTrailer = movieTrailerResponse ?? []
            DispatchQueue.main.async {
                LoadingView.stop(view: self.view)
            }
        }
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
