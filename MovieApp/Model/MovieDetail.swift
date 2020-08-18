//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Can Kalender on 18.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//

import Foundation
struct MovieDetail : Codable {
    let overview: String?
    let poster : String?

    enum CodingKeys: String, CodingKey {

        case poster = "poster_path"
        case overview = "overview"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        poster = try values.decodeIfPresent(String.self, forKey: .poster)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        
    }

}
