# Timerable ⏰
## The most perfect Swift Timer you'll ever need.
This is a protocol oriented Timer Factory with all the features you'll ever need. I wrote it in both RxSwift and Native Swift. hope you'll enjoy.
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
⚠️ for better understanding read the line by line code documentation ⚠️
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
