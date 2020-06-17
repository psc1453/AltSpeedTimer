//
//  AltSpeedTimer.swift
//  AltSpeedTimer
//
//  Created by 彭世辰 on 2020/6/14.
//  Copyright © 2020 Peng Shichen. All rights reserved.
//

import Foundation
import SwiftUI

class AltSpeedTimer: ObservableObject {
    @Published var timerState: TimerState
    @Published var timeSetting: Double
    @Published var timeLeft: Double
    var speed: Double
    
    var timer: Timer
    
    init() {
        timerState = TimerState.initial
        timeSetting = 60.0
        timeLeft = 60.0
        speed = 1.0
        timer = Timer()
    }
    
    convenience init(setTime: Double, setSpeed: Double) {
        self.init()
        timeSetting = setTime
        timeLeft = setTime
        speed = setSpeed
    }
    
    func setTime(minutes: Int, seconds: Int) {
        timeSetting = Double(60 * minutes + seconds)
        timeLeft = Double(60 * minutes + seconds)
    }
    
    func start() {
        timerState = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            if self.timeLeft < (1.0 / self.speed) {
                self.timeLeft = 0
            }
            else {
                self.timeLeft -= self.speed * 0.1
                print(getSeconds(second: self.timeLeft))
            }
        })
    }
    
    func reset() {
        timerState = .initial
        timeLeft = timeSetting
        timer.invalidate()
    }
    
    func pause() {
        timerState = .paused
        timer.invalidate()
    }
}
