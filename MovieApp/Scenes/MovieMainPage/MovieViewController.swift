//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Can Kalender on 16.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!

    private var movies: [Movie] = [] {
        didSet {
            if movies.count == 0 {
                    DispatchQueue.main.async {
                        self.tableView.showTableViewEmptyLabel(message: "Enter a movie name.", containerView: self.tableView)
                    }
            }else {
                DispatchQueue.main.async {
                    self.tableView.hideTableViewEmptyMessage()
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var page = 1
    private var isNewDataLoading = false
    private var isEnd = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movies"
        getMovies(page)
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    
    
    func getMovies(_ page: Int) {
        if !isEnd {
            LoadingView.start(view: self.view)
            NetworkManager.shared.getMovies(page: page) { (moviesResponse, isEnd, responseError, error) in
                if let responseError = responseError {
                    DispatchQueue.main.async {
                        self.tableView.showTableViewEmptyLabel(message: responseError, containerView: self.tableView)
                    }
                }
                if page == Constant.pageStartIndex {
                    self.movies = moviesResponse ?? []
                }else {
                    self.movies.append(contentsOf: moviesResponse ?? [])
                }
                self.isEnd = isEnd
                DispatchQueue.main.async {
                    LoadingView.stop(view: self.view)
                }
                self.isNewDataLoading = false
            }
        }
    }
    
}

extension MovieViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.layer.masksToBounds = true;
        cell.layer.cornerRadius = 15;
        cell.backgroundColor = .white
        cell.setUI(movie)

        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row+Constant.lazyLoadingBeforeCellCount >= movies.count {
            if !isNewDataLoading{
                isNewDataLoading = true
                page = page+1
                getMovies(page)
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let movieDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailController.movieId = movie.id
        self.navigationController?.pushViewController(movieDetailController, animated: true)

    }
}


class Constant {

    static let lazyLoadingBeforeCellCount = 2
    static let movieCellHeight = CGFloat(integerLiteral: 120)
    static let pageStartIndex = 1
}



