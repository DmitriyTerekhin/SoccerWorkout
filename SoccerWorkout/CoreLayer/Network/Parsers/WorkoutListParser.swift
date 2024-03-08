//

import Foundation
import SwiftyJSON

class WorkoutListParser: IParser {
    
    typealias Model = [WorkoutDTO]
    
    private var isHistoryList: Bool
    
    init(isHistoryList: Bool = false) {
        self.isHistoryList = isHistoryList
    }
    
    func parse(json: JSON) -> Model? {
        return json.arrayValue.map { workoutJSON in
            let exercisesLevel0 = workoutJSON["exercises"]["level0"].arrayValue.map { exerciseJSON in
                return ExerciseDTO(id: exerciseJSON["id"].stringValue,
                                   name: exerciseJSON["name"].stringValue,
                                   approach: exerciseJSON["approach"].intValue,
                                   time: exerciseJSON["time"].intValue,
                                   repetition: exerciseJSON["repetition"].intValue,
                                   totalTime: exerciseJSON["totalTime"].intValue,
                                   videoLink: ApiConstants.URL.base + "/" + exerciseJSON["videoLink"].stringValue
                )
            }
            let exercisesLevel1 = workoutJSON["exercises"]["level1"].arrayValue.map { exerciseJSON in
                return ExerciseDTO(id: exerciseJSON["id"].stringValue,
                                   name: exerciseJSON["name"].stringValue,
                                   approach: exerciseJSON["approach"].intValue,
                                   time: exerciseJSON["time"].intValue,
                                   repetition: exerciseJSON["repetition"].intValue,
                                   totalTime: exerciseJSON["totalTime"].intValue,
                                   videoLink: ApiConstants.URL.base + "/" + exerciseJSON["videoLink"].stringValue
                )
            }
            let exercisesLevel2 = workoutJSON["exercises"]["level2"].arrayValue.map { exerciseJSON in
                return ExerciseDTO(id: exerciseJSON["id"].stringValue,
                                   name: exerciseJSON["name"].stringValue,
                                   approach: exerciseJSON["approach"].intValue,
                                   time: exerciseJSON["time"].intValue,
                                   repetition: exerciseJSON["repetition"].intValue,
                                   totalTime: exerciseJSON["totalTime"].intValue,
                                   videoLink: ApiConstants.URL.base + "/" + exerciseJSON["videoLink"].stringValue
                )
            }
            let exByLevels = ExerciseLevels(level0: exercisesLevel0,
                                            level1: exercisesLevel1,
                                            level2: exercisesLevel2)
            return WorkoutDTO(id: isHistoryList ? workoutJSON["history_id"].intValue : workoutJSON["id"].intValue,
                              date: workoutJSON["date"].stringValue,
                              type: workoutJSON["type"].stringValue,
                              excercise: exByLevels
            )
        }
    }
}
