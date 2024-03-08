//

import Foundation
import SwiftyJSON

class HistoryParser: IParser {
    typealias Model = Int
    func parse(json: JSON) -> Model? {
        return json["history_id"].int
    }
}
