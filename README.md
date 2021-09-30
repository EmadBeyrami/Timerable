# Timerable ⏰
## The most perfect Swift Timer you'll ever need.
A protocol-oriented Timer Factory with all the features you'll ever need.
I wrote it in both RxSwift and Native Swift. hope you'll enjoy.
If you find this useful don't forget to star ⭐️.

### features
- Solved the background time problem: if your app state changes to background the timer won't stop and if you open the app you'll see the timer is still update.
- Easy to use: Instead of making a timer for each part of your code easily use this few lines of codes.
- Disposable: Instead of calling deinit to invalidate timer and remove the timer from memory manually just use this and it will do that automatically.
- Protocol Oriented: You can conform to this protocol to easily use it.
- Reactive
- Developer friendly

## Timerable
The Native Swift Timer. If you are using native swift and not using RxSwift you can use this file.

## RxTimerable
The RxSwift Timer. If you are using RxSwift you can use this File.

# Usage
1. Simply just download and add  `RxTimerable` or `Timerable` to your project.
2. in the class or wherever you want to use this Timer simply add these lines of codes.

 ⚠️ For better understanding read the line by line code documentation ⚠️
``` 
let timer = TimeCounter()
let decreasingTime = TimeDecreasing(time: [.seconds(30)])
let increasingTime = TimeIncreasing(time: [.days(1), .minutes(34), .seconds(20)])
        
timer.setTimer(time: decreasingTime)
timer.start()
        
timer.timerDidEnd { in
    print("Time Ended ")
}

timer.bind { model in
    print("log", model)
}
```

## line by line guideline
To use timer we need an instance:
`let timer = TimeCounter()`

to tell timer what to do, we need a set of rules so we can pass whatever conforms to `Timerable` Protocol to initial the timer
`timer.setTimer(time: Timerable)`

I already made two type of `Timerable` in `TimerModels.swift` containing `TimeIncreasing` and `TimeDecreasing`.
for decreasing Timer you can use:
`let decreasingTime = TimeDecreasing(time: [.seconds(30)])`
for increasing Timer you can use:
`let increasingTime = TimeIncreasing(time: [.days(1), .minutes(34), .seconds(20)])`

after assigning initial values you MUST START the timer, to do so:
`timer.start()`

for binding to Timer there are two callbacks:
1. for binding to update the UI or do something in each interval you must use:
`timer.bind { model in
    print("log", model)
}`

⚠️ Note: Do not forget to use `weak self` or `unowned self` to avoid retain cycle.

2. for binding to finishing timer you should use:
`timer.timerDidEnd { in
    print("Time Ended ")
}`
