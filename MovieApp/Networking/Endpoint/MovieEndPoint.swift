//
//  MovieEndPoint.swift
//  MovieApp
//
//  Created by Can Kalender on 17.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum MovieApi {
    case movie(page:Int)
    case movieDetail(id: Int)
    case movieTrailer(id:Int)
}

extension MovieApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
            case .production: return "https://api.themoviedb.org/3"
        case .qa: return ""
        case .staging: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .movie(_):
            return "/trending/movie/week"
        case .movieDetail(let id):
            return "/movie/\(id)"
        case .movieTrailer(let id):
            return "/movie/\(id)/videos"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    //https://api.themoviedb.org/3/trending/movie/week?api_key=a163d3b6a3074aec0f4bd568cebe17da
    var task: HTTPTask {
        switch self {
            // case for send parameter(body)
            case .movie(let page):
                return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: [
                    "api_key":NetworkManager.MovieAPIKey,
                    "page": page,
                ])
            case .movieDetail(_):
                return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: [
                    "api_key":NetworkManager.MovieAPIKey,
                ])
            case .movieTrailer(_):
                return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: [
                    "api_key":NetworkManager.MovieAPIKey,
                ])
            
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
