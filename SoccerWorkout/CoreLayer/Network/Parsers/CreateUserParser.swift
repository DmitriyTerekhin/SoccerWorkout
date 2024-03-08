//

import Foundation
import SwiftyJSON

class CreateUserParser: IParser {
    
    typealias Model = AuthDTO
    
    func parse(json: JSON) -> Model? {
        let dataJson = json
        return AuthDTO(level: dataJson["level"].intValue,
                       userId: dataJson["id"].stringValue)
    }
}
