// RxTimeCounter.Swift
//
// Designed and Developed By Emad Bayrami & Mohamad NasrAbadi
// Link to Repo: https://github.com/EmadBeyrami/Timerable

import UIKit
import Foundation
import RxSwift
import RxCocoa

typealias Completion = (() -> Void)
typealias DataCompletion<T> = ((T) -> Void)

class TimeCounter {
    
    private (set) var state: TimerState?
    
    // MARK: - Properties
    private var backgroundTime: Date?
    private var background_forground_timelaps: Int?
    private let disposeBag = DisposeBag()
    private var sourceObservable: Disposable?
    private var second: Double = 0
    
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
        sourceObservable?.dispose()
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
        UIApplication.rx.willEnterForeground
            .subscribe({ [weak self] _ in
                guard let self = self else { return }
                guard let date = self.backgroundTime else { return }
                let component = Calendar.current.dateComponents([.second], from: date, to: Date())
                self.background_forground_timelaps = component.second
                self.backgroundTime = nil
            }).disposed(by: disposeBag)
        
        UIApplication.rx.didEnterBackground
            .subscribe({ [weak self] _ in
                guard let self = self else { return }
                self.background_forground_timelaps = nil
                self.backgroundTime = Date()
            }).disposed(by: disposeBag)
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
        
        sourceObservable = Observable<Int>
            .interval(RxTimeInterval.seconds(time.repeatTime), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.checkTheDifference()
                self.updateTime()
            })
    }
    
    private func timeDone() {
        timeEnded()
        sourceObservable?.dispose()
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
