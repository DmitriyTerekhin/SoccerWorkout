//
//  IParser.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation
import SwiftyJSON

protocol IParser {
    associatedtype Model
    func parse(json: JSON) -> Model?
    func parseOnError(json: JSON) -> NetworkError?
}

extension IParser {
    func parseOnError(json: JSON) -> NetworkError? {
        guard
            let code = json["result_code"].int,
            code != 100 && code != 200
        else {
            return nil
        }
        guard let text = json["data"]["text"].string else {
            return nil
        }
        return NetworkError.customError(code, text)
    }
}
