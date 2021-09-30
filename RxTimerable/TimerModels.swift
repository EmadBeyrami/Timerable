// RxTimeCounter.Swift
//
// Designed and Developed By Emad Bayrami & Mohamad NasrAbadi
// Link to Repo: https://github.com/EmadBeyrami/Timerable

import Foundation

// MARK: - Default Models
// you can add more default models

// MARK: Decreasing Timer Model
struct TimeDecreasing: Timerable {
    let time: [TimeIntervalType]
    let timerType: TimerType = .decreasing
    let repeatTime: Int = 1
    let jumpInterval: Double = 1
    let endTime: [TimeIntervalType] = [.seconds(0)]
    
    init(time: [TimeIntervalType]) {
        self.time = time
    }
}

// MARK: Increasing Timer Model
struct TimeIncreasing: Timerable {
    let time: [TimeIntervalType] = [.seconds(0)]
    let timerType: TimerType = .increasing
    let repeatTime: Int = 1
    let jumpInterval: Double = 1
    let endTime: [TimeIntervalType]
    
    init(time: [TimeIntervalType]) {
        self.endTime = time
    }
}
