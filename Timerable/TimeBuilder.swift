// TimeBuilder.Swift
//
// Designed and Developed By Emad Bayrami & Mohamad NasrAbadi
// Link to Repo: https://github.com/EmadBeyrami/Timerable

import Foundation

class TimeBuilder {
    
    /**
     This creates `convert Double to Time Srting`
     
     # USE
     ```
     let timeBuilder = TimeBuilder()
     return timeBuilder.getTimeString(cardNumber)
     ```
     - Parameter time: `Time`
     - Returns: `(hours, minutes, seconds)`
     */
    func getTimeString(_ time: Double) -> TimeModel {
        
        let intTime: Int = Int(time)
        let days = intTime / 86400
        let hours = (intTime % 86400) / 3600
        let minutes = (intTime % 3600) / 60
        let seconds = (intTime % 3600) % 60
        
        let timeModel = TimeModel(days: days, hours: hours, minutes: minutes, seconds: seconds)
        
        return timeModel
    }
    
    /**
     This creates `convert Double to Time Srting`
     
     # USE
     ```
     let timeBuilder = TimeBuilder()
     return timeBuilder.getTime(time, timeType)
     ```
     - Parameter time: `Time`
     - Parameter timeType: `TimeType`
     - Returns: " `hours` : `minutes` : `seconds` "
     */
    func getTime(_ time: Double, type: TimeType = .inDay) -> String {
        let timeString: TimeModel = getTimeString(time)
        let days = timeString.days
        let hours = timeString.hours
        let minutes = timeString.minutes
        let seconds = timeString.seconds
        switch type {
        case .inDay:
            return String(format: "%@:%@:%@", hours, minutes, seconds)
        case .inMonth:
            return String(format: "%@:%@:%@:%@", days, hours, minutes, seconds)
        }
    }
}

// MARK: - Models
struct TimeModel {
    var days: String
    var hours: String
    var minutes: String
    var seconds: String
    
    init(days: Int, hours: Int, minutes: Int, seconds: Int) {
        self.days = TimeModel.checkForZero(days)
        self.hours = TimeModel.checkForZero(hours)
        self.minutes = TimeModel.checkForZero(minutes)
        self.seconds = TimeModel.checkForZero(seconds)
        if days > 30 {
            self.days = "30+"
        }
    }
    
    private static func checkForZero(_ time: Int) -> String {
        return "\(time < 10 ? "0" : "")\(time)"
    }
}
/**
- parameters: `.inMonth`->  contains: Days, hours, minute, second
- Parameters: `.inDay`    ->  contains: hours, minute, second
 **/
enum TimeType {
    case inDay
    case inMonth
}
