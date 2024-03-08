//

import Foundation

extension String {
    
    enum DateFormats {
        case YYYYMMDDTHHMMSS
        case YYYYMMDDHHMM
        case YYYYMMDDHHMMSS
        case dMMMM
        case ddMMYYYY
        case YYYYMMDD
        case ddMMYYYY_HHMM
        
        var format: String {
            switch self {
            case .YYYYMMDDTHHMMSS:
                return "yyyy-MM-dd'T'HH:mm:ss"
            case .YYYYMMDDHHMMSS:
                return "yyyy-MM-dd HH:mm:ss"
            case .YYYYMMDDHHMM:
                return "yyyy.MM.dd HH:mm"
            case .dMMMM:
                return "d MMMM"
            case .ddMMYYYY:
                return "dd.MM.yyyy"
            case .ddMMYYYY_HHMM:
                return "dd.MM.yyyy  HH:mm"
            case .YYYYMMDD:
                return "yyyy-MM-dd"
            }
        }
    }
    
    func toDate(withFormat: DateFormats)  -> Date? {
        var dateString = self
        if dateString.contains("0000") && withFormat == .ddMMYYYY {
            dateString = dateString.replacingOccurrences(of: ".0000", with: ".0001")
        }
        let formatter = DateFormatter()
        formatter.dateFormat = withFormat.format
        return formatter.date(from: dateString)
    }
    
    func toDate(withFormat: String)  -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = withFormat
        return formatter.date(from: self)
    }
    
    private func checkYears(dateString: String) -> String {
        dateString.replacingOccurrences(of: "0000", with: "0001")
    }
}
