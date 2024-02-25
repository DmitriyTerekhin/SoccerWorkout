//
//  SucceedParser.swift
//  Workout
//
//  Created by Ju on 20.02.2024.
//

import Foundation
import SwiftyJSON

class SucceedParser: IParser {
    typealias Model = Bool
    func parse(json: JSON) -> Model? {
        return json["error"].string == nil
    }
}
