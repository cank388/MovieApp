//
//  Movie.swift
//  MovieApp
//
//  Created by Can Kalender on 16.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//

import Foundation

//"id": 605116,
//"video": false,
//"vote_count": 165,
//"vote_average": 6.5,
//"title": "Project Power",
//"release_date": "2020-08-14",
//"original_language": "en",
//"original_title": "Project Power",
//"genre_ids": [
//  28,
//  80,
//  878
//],
//"backdrop_path": "/qVygtf2vU15L2yKS4Ke44U4oMdD.jpg",
//"adult": false,
//"overview": "An ex-soldier, a teen and a cop collide in New Orleans as they hunt for the source behind a dangerous new pill that grants users temporary superpowers.",
//"poster_path": "/fjCezXiQWfGuNf4t7LruKky7kwV.jpg",
//"popularity": 98.969,
//"media_type": "movie"

struct MovieApiResponse : Codable {
    let movies : [Movie]?
    let totalResults : Int?
    let response : String?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case movies = "results"
        case totalResults = "total_results"
        case response = "Response"
        case error = "Error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decodeIfPresent([Movie].self, forKey: .movies)
        totalResults = try values.decode(Int.self, forKey: .totalResults)
        response = try values.decodeIfPresent(String.self, forKey: .response)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
}


struct Movie : Codable {
    let title : String?
    let year : String?
    let overview: String?
    let id : Int?
    let poster : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case year = "release_date"
        case id = "id"
        case poster = "poster_path"
        case overview = "overview"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        year = try values.decodeIfPresent(String.self, forKey: .year)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        poster = try values.decodeIfPresent(String.self, forKey: .poster)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        
    }

}
