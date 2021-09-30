// RxTimeCounter.Swift
//
// Designed and Developed By Emad Bayrami & Mohamad NasrAbadi

import UIKit
import Foundation

typealias Completion = (() -> Void)
typealias DataCompletion<T> = ((T) -> Void)

// MARK: - Timer
class TimeCounter {
    
    private (set) var state: TimerState?
    
    // MARK: - Properties
    private var backgroundTime: Date?
    private var background_forground_timelaps: Int?
    private var second: Double = 0
    
    private lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource()
        t.schedule(deadline: .now(), repeating: self.time.repeatTime)
        t.setEventHandler(handler: { [weak self] in
            guard let self = self else { return }
            self.checkTheDifference()
            self.updateTime()
        })
        return t
    }()
    
    private var isTimerWorking: Bool {
        guard state != nil else {
            print("⏰ you should call 'START()' First!")
            return false
        }
        return true
    }
    
    var stringTime: TimeModel {
        let timeBuilder = TimeBuilder()
        return timeBuilder.getTimeString(second)
    }
    
    // MARK: - LifeCycle
    
    // initializer
    private var time: Timerable!
    func setTimer(time: Timerable) {
        self.time = time
        self.second = time.time.seconds
    }
    
    // deinitializer
    deinit {
        timer.setEventHandler {}
        timer.cancel()
        /*
         If the timer is suspended, calling cancel without resuming
         triggers a crash. This is documented here https://forums.developer.apple.com/thread/15902
         */
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        print("REMOVED \(self) FROM MEMORY")
        print(time.description)
    }
    
    // MARK: - Timer Helper
    fileprivate func checkTheDifference() {
        guard let BGAFTimelapse = background_forground_timelaps else { return }
        guard backgroundTime == nil else { return }
        switch time.timerType {
        case .decreasing:
            self.second -= Double(BGAFTimelapse)
        case .increasing:
            self.second += Double(BGAFTimelapse)
        }
        background_forground_timelaps = nil
    }
    
    // MARK: - Bindings and actions
    fileprivate func appStateBinding() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackgroundNotification), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForegroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc fileprivate func didEnterBackgroundNotification() {
        self.background_forground_timelaps = nil
        self.backgroundTime = Date()
    }
    
    @objc fileprivate func willEnterForegroundNotification() {
        guard let date = self.backgroundTime else { return }
        let component = Calendar.current.dateComponents([.second], from: date, to: Date())
        self.background_forground_timelaps = component.second
        self.backgroundTime = nil
    }
    
    private var timeEnded: Completion = { }
    func timerDidEnd(timeEnded: @escaping Completion) {
        self.timeEnded = timeEnded
    }
    
    private var logTime: DataCompletion<TimeModel> = { _ in }
    func bind(_ log: @escaping DataCompletion<TimeModel>) {
        logTime = log
    }
    
    // MARK: - Timer Logic
    
    // Timer Start
    func start() {
        guard state == nil else { return }
        state = .working
        appStateBinding()
        timer.resume()
    }
    
    private func timeDone() {
        timeEnded()
        timer.suspend()
        state = .suspended
    }
    
    // Update Time Logic
    fileprivate func updateTime() {
        
        switch time.timerType {
        case .increasing:
            if second >= time.endTime.seconds {
                timeDone()
                return
            }
            second += time.jumpInterval
            
        case .decreasing:
            if second <= time.endTime.seconds || second <= 0 {
                timeDone()
                return
            }
            second -= time.jumpInterval
        }
        logTime(stringTime)
    }
    
}
