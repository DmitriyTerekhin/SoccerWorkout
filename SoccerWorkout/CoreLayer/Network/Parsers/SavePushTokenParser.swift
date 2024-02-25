//
//  SavePushTokenParser.swift
//  Workout
//
//  Created by Ju on 19.02.2024.
//

import Foundation
import SwiftyJSON

class SavePushTokenParser: IParser {
    typealias Model = Bool
    
    func parse(json: JSON) -> Model? {
        return true
    }
}
