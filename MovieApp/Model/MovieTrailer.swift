//
//  MovieTrailer.swift
//  MovieApp
//
//  Created by Can Kalender on 19.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//

//"id": "5f0f0e369672ed00364c4619",
//"iso_639_1": "en",
//"iso_3166_1": "US",
//"key": "xw1vQgVaYNQ",
//"name": "Project Power starring Jamie Foxx | Official Trailer | Netflix",
//"site": "YouTube",
//"size": 1080,
//"type": "Trailer"

import Foundation

struct MovieTrailerApiResponse : Codable {
    let movieTrailers : [MovieTrailer]?

    enum CodingKeys: String, CodingKey {

        case movieTrailers = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movieTrailers = try values.decodeIfPresent([MovieTrailer].self, forKey: .movieTrailers)
    }
}
struct MovieTrailer : Codable {
    let key : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case key = "key"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        
    }

}
