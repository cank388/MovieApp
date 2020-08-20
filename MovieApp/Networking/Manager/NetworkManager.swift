//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Can Kalender on 17.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//


import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    static let environment : NetworkEnvironment = .production
    static let MovieAPIKey = "a163d3b6a3074aec0f4bd568cebe17da" // 17.08.2020(Valid)
    static var posterBaseURL = "https://image.tmdb.org/t/p/w500/?api_key=\(MovieAPIKey)"
    let router = Router<MovieApi>()
    
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }

    func getMovies(page: Int, completion: @escaping (_ movie: [Movie]?, _ isEnd: Bool, _ responseError: String?, _ error: String?)->()){
        router.request(.movie(page: page)) { data, response, error in

            if error != nil {
                completion(nil, false, nil, "Please check your network connection.")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil, false, nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
//                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
                            completion(apiResponse.movies, Int(page) == apiResponse.totalResults, apiResponse.error, nil)
                        }catch {
                            completion(nil, false, nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    case .failure(let networkFailureError):
                        completion(nil, false, nil, networkFailureError)
                }
            }
        }
    }

    func getMovieDetail(movieId: Int, completion: @escaping (_ movieDetail: MovieDetail?,_ error: String?)->()){
        router.request(.movieDetail(id: movieId)) { data, response, error in

            if error != nil {
                completion(nil, "Please check your network connection.")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                            print(responseData)
                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            print(jsonData)
                            let apiResponse = try JSONDecoder().decode(MovieDetail.self, from: responseData)
                            completion(apiResponse,nil)
                        }catch {
                            print(error)
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    case .failure(let networkFailureError):
                        completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getMovieTrailer(movieId: Int, completion: @escaping (_ movieDetail: [MovieTrailer]?,_ error: String?)->()){
        router.request(.movieTrailer(id: movieId)) { data, response, error in

            if error != nil {
                completion(nil, "Please check your network connection.")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                            print(responseData)
                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            print(jsonData)
                            let apiResponse = try JSONDecoder().decode(MovieTrailerApiResponse.self, from: responseData)
                            completion(apiResponse.movieTrailers,nil)
                        }catch {
                            print(error)
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    case .failure(let networkFailureError):
                        completion(nil, networkFailureError)
                }
            }
        }
    }
    
    
}
