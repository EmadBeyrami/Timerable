// RxTimeCounter.Swift
//
// Designed and Developed By Emad Bayrami & Mohamad NasrAbadi

import Foundation

// MARK: - Timerable
protocol Timerable {
    var time: [TimeIntervalType] { get }
    var timerType: TimerType { get }
    var repeatTime: Double { get }
    var jumpInterval: Double { get }
    var endTime: [TimeIntervalType] { get }
}

extension Timerable {
    var repeatTime: Double { 1 }
    var jumpInterval: Double { 1 }
}

extension Timerable {
    var description: String {
        return """
        time: \(time)
        timerType: \(timerType)
        repeatTime: \(repeatTime)
        jumpTime: \(jumpInterval)
        endTime: \(endTime)
        ⏲
        """
    }
}

enum TimeIntervalType {
    case days(Double)
    case hours(Double)
    case minutes(Double)
    case seconds(Double)
    
    var second: Double {
        switch self {
        case .days(let day):
            return (day * 24) * 60 * 60
        case .hours(let hour):
            return (hour * 60) * 60
        case .minutes(let minute):
            return (minute * 60)
        case .seconds(let second):
            return second
        }
    }
}

enum TimerState {
    case working
    case resumed
    case suspended
}

enum TimerType {
    case increasing
    case decreasing
}

extension Sequence where Self == [TimeIntervalType] {
    var seconds: Double {
        self.compactMap({ $0.second }).reduce(0, +)
    }
}
