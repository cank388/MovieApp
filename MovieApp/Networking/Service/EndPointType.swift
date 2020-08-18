//
//  EndPointType.swift
//  MovieApp
//
//  Created by Can Kalender on 16.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
