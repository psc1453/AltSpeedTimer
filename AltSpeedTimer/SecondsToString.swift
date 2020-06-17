//
//  TimeToString.swift
//  AltSpeedTimer
//
//  Created by 彭世辰 on 2020/6/14.
//  Copyright © 2020 Peng Shichen. All rights reserved.
//

import Foundation

func getMinutes(second: Double) -> String {
    let minutes = String(format: "%02.0f", floor(second / 60.0))
    return minutes
}

func getSeconds(second: Double) -> String {
    let seconds = String(format: "%02.0f", floor(second - floor(second / 60.0) * 60.0))
    return seconds
}

func getMilliseconds(second: Double) -> String {
    let milliseconds = String(format: "%02.0f", floor((second - floor(second)) * 60))
    return milliseconds
}
