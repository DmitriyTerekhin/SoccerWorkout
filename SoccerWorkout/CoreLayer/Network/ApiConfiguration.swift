//
//  ApiConfiguration.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation
import Alamofire

protocol ApiConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders { get }
}
