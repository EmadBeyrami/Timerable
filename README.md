# Timerable
Easy to use Swift Timer

#Usage
``` let timer = STRTimeCounter()
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
