//

import Foundation

enum GoalTime: Int, CaseIterable {
    case twoMonth
    case fourMonth
    case sixMonth
    
    var title: String {
        switch self {
        case .twoMonth:
            return "2 Months"
        case .fourMonth:
            return "4 Months"
        case .sixMonth:
            return "6 Months"
        }
    }
}

enum ChooseGoalViewState {
    case setup(currentSkill: Skill)
    case edit(currentSkill: Skill)
}
